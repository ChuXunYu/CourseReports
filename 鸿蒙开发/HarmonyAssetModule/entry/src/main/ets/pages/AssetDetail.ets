import router from '@ohos.router';
import { AssetItem, AssetStatusMapper } from '../common/AssetModel';

@Entry
@Component
struct AssetDetail {
  @State asset: AssetItem = router.getParams() as AssetItem;
  @State statusLabel: string = '';

  aboutToAppear() {
    this.statusLabel = AssetStatusMapper.label(this.asset.status);
  }

  build() {
    Navigation() {
      Column({ space: 18 }) {
        Column({ space: 8 }) {
          Text(this.asset.assetName)
            .fontSize(26)
            .fontWeight(FontWeight.Bold)
            .fontColor('#17212B')
          Text(this.asset.assetCode)
            .fontSize(15)
            .fontColor('#66727F')
        }
        .alignItems(HorizontalAlign.Start)
        .width('100%')

        this.InfoBlock('当前状态', this.statusLabel)
        this.InfoBlock('设备分类', this.asset.categoryName)
        this.InfoBlock('使用部门', this.asset.departmentName)
        this.InfoBlock('供应商', this.asset.supplierName)
        this.InfoBlock('保管人', this.asset.keeper)
        this.InfoBlock('资产原值', `￥${this.asset.originalValue}`)
        this.InfoBlock('备注', this.asset.remark)

        Button('标记为使用中')
          .width('100%')
          .height(48)
          .fontSize(16)
          .backgroundColor('#1C6F63')
          .borderRadius(14)
          .onClick(() => {
            this.statusLabel = '使用中';
          })

        Button('返回资产列表')
          .width('100%')
          .height(46)
          .fontSize(16)
          .fontColor('#1C6F63')
          .backgroundColor('#E7F3F0')
          .borderRadius(14)
          .onClick(() => {
            router.back();
          })
      }
      .width('100%')
      .height('100%')
      .padding({ left: 20, right: 20, top: 20, bottom: 20 })
      .backgroundColor('#F4F7F8')
    }
    .title('资产详情')
    .mode(NavigationMode.Stack)
  }

  @Builder
  InfoBlock(label: string, value: string) {
    Column({ space: 6 }) {
      Text(label)
        .fontSize(13)
        .fontColor('#66727F')
      Text(value)
        .fontSize(17)
        .fontWeight(FontWeight.Medium)
        .fontColor('#17212B')
    }
    .width('100%')
    .padding(16)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
  }
}
