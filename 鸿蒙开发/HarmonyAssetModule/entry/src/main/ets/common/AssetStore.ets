import { AssetItem, AssetStatus, assetSeedData } from './AssetModel';

export interface AssetDraft {
  assetCode: string;
  assetName: string;
  categoryName: string;
  departmentName: string;
  supplierName: string;
  status: AssetStatus;
  keeper: string;
  originalValue: number;
  remark: string;
}

interface StoreResult {
  success: boolean;
  message: string;
}

let localAssets: AssetItem[] = assetSeedData.map((asset: AssetItem) => copyAsset(asset));
let nextAssetId: number = localAssets.length + 1;

function copyAsset(asset: AssetItem): AssetItem {
  return {
    id: asset.id,
    assetCode: asset.assetCode,
    assetName: asset.assetName,
    categoryName: asset.categoryName,
    departmentName: asset.departmentName,
    supplierName: asset.supplierName,
    status: asset.status,
    keeper: asset.keeper,
    originalValue: asset.originalValue,
    remark: asset.remark
  };
}

function createAssetCode(): string {
  let serial = nextAssetId.toString();
  if (nextAssetId < 10) {
    serial = `00${nextAssetId}`;
  } else if (nextAssetId < 100) {
    serial = `0${nextAssetId}`;
  }
  return `ASSET-2026-${serial}`;
}

export class AssetStore {
  static list(): AssetItem[] {
    return localAssets.map((asset: AssetItem) => copyAsset(asset));
  }

  static findByCode(assetCode: string): AssetItem | undefined {
    const matched = localAssets.find((asset: AssetItem) => asset.assetCode === assetCode);
    return matched ? copyAsset(matched) : undefined;
  }

  static add(draft: AssetDraft): StoreResult {
    const assetName = draft.assetName.trim();
    const assetCode = draft.assetCode.trim().length > 0 ? draft.assetCode.trim() : createAssetCode();

    if (assetName.length === 0) {
      return { success: false, message: '请输入设备名称' };
    }

    const duplicated = localAssets.some((asset: AssetItem) => asset.assetCode === assetCode);
    if (duplicated) {
      return { success: false, message: '资产编号已存在' };
    }

    localAssets.unshift({
      id: nextAssetId,
      assetCode: assetCode,
      assetName: assetName,
      categoryName: draft.categoryName.trim().length > 0 ? draft.categoryName.trim() : '计算机设备',
      departmentName: draft.departmentName.trim().length > 0 ? draft.departmentName.trim() : '未分配',
      supplierName: draft.supplierName.trim().length > 0 ? draft.supplierName.trim() : '未登记',
      status: draft.status,
      keeper: draft.keeper.trim().length > 0 ? draft.keeper.trim() : '待分配',
      originalValue: draft.originalValue > 0 ? draft.originalValue : 0,
      remark: draft.remark.trim().length > 0 ? draft.remark.trim() : '新增设备'
    });
    nextAssetId += 1;

    return { success: true, message: '设备已新增' };
  }

  static updateStatus(assetCode: string, status: AssetStatus): StoreResult {
    const target = localAssets.find((asset: AssetItem) => asset.assetCode === assetCode);
    if (!target) {
      return { success: false, message: '未找到资产记录' };
    }

    target.status = status;
    return { success: true, message: '状态已更新' };
  }
}
