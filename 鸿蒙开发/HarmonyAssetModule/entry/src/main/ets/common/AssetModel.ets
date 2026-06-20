export type AssetStatus = 'IN_STOCK' | 'IN_USE' | 'REPAIR' | 'SCRAPPED';

export interface AssetItem {
  id: number;
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

export class AssetStatusMapper {
  static label(status: AssetStatus): string {
    const labels: Record<AssetStatus, string> = {
      IN_STOCK: '在库',
      IN_USE: '使用中',
      REPAIR: '维修中',
      SCRAPPED: '已报废'
    };
    return labels[status];
  }
}

export const assetSeedData: AssetItem[] = [
  {
    id: 1,
    assetCode: 'ASSET-2026-001',
    assetName: '国产数据库实训服务器',
    categoryName: '计算机设备',
    departmentName: '软件实训室',
    supplierName: '国产软硬件集成有限公司',
    status: 'IN_USE',
    keeper: '宋老师',
    originalValue: 28600,
    remark: '用于金仓数据库课程实训'
  },
  {
    id: 2,
    assetCode: 'ASSET-2026-002',
    assetName: '网络交换机',
    categoryName: '网络设备',
    departmentName: '网络实训室',
    supplierName: '华北信息技术服务有限公司',
    status: 'IN_STOCK',
    keeper: '王老师',
    originalValue: 4200,
    remark: '备用网络实训设备'
  },
  {
    id: 3,
    assetCode: 'ASSET-2026-003',
    assetName: '数据库课程演示终端',
    categoryName: '计算机设备',
    departmentName: '软件实训室',
    supplierName: '北京教学设备有限公司',
    status: 'REPAIR',
    keeper: '实训管理员',
    originalValue: 6500,
    remark: '用于鸿蒙端资产管理演示'
  }
];
