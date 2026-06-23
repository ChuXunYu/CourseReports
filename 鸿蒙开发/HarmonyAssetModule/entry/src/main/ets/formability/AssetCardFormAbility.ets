import { Want } from '@kit.AbilityKit';
import { formBindingData, FormExtensionAbility } from '@kit.FormKit';
import { AssetSummary, buildAssetSummary } from '../common/AssetModel';
import { AssetStore } from '../common/AssetStore';

interface AssetCardData {
  totalCount: number;
  repairCount: number;
  inStockCount: number;
  inUseCount: number;
  title: string;
  description: string;
}

export default class AssetCardFormAbility extends FormExtensionAbility {
  onAddForm(want: Want) {
    return formBindingData.createFormBindingData(this.buildCardData());
  }

  onUpdateForm(formId: string): void {
    this.context.updateForm(formId, formBindingData.createFormBindingData(this.buildCardData()));
  }

  private buildCardData(): AssetCardData {
    const summary: AssetSummary = buildAssetSummary(AssetStore.list());
    return {
      totalCount: summary.totalCount,
      repairCount: summary.repairCount,
      inStockCount: summary.inStockCount,
      inUseCount: summary.inUseCount,
      title: '资产台账',
      description: '教学设备资产统计'
    };
  }
}
