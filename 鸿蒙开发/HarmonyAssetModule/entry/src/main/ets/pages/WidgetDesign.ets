import router from '@ohos.router';
import { AssetItem, AssetSummary, buildAssetSummary } from '../common/AssetModel';
import { AssetStore } from '../common/AssetStore';

@Entry
@Component
struct WidgetDesign {
  @State selectedSize: string = '2x2';
  @State syncMessage: string = '统计已同步，可作为万能卡片展示';
  @State assets: AssetItem[] = AssetStore.list();

  aboutToAppear() {
    this.assets = AssetStore.list();
  }

  private get summary(): AssetSummary {
    return buildAssetSummary(this.assets);
  }

  private get repairAssets(): AssetItem[] {
    return this.assets.filter((asset: AssetItem) => asset.status === 'REPAIR');
  }

  build() {
    Navigation() {
      Column({ space: 16 }) {
        this.PageHeader()
        this.SizeSwitcher()
        this.AssetWidgetCard()
        this.StatsDetail()
        this.ActionPanel()
      }
      .width('100%')
      .height('100%')
      .padding({ left: 20, right: 20, top: 18, bottom: 20 })
      .backgroundColor('#F4F7F8')
    }
    .title('万能卡片设计')
    .mode(NavigationMode.Stack)
  }

  @Builder
  PageHeader() {
    Column({ space: 6 }) {
      Text('资产台账服务卡片')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor('#17212B')
      Text('将资产总览和高频入口前置到桌面或元服务入口')
        .fontSize(14)
        .fontColor('#66727F')
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }

  @Builder
  SizeSwitcher() {
    Row({ space: 10 }) {
      this.SizePill('2x2', '2 × 2')
      this.SizePill('2x4', '2 × 4')
      Blank()
      Text(this.syncMessage)
        .fontSize(12)
        .fontColor('#66727F')
    }
    .width('100%')
  }

  @Builder
  SizePill(value: string, label: string) {
    Text(label)
      .fontSize(13)
      .fontWeight(this.selectedSize === value ? FontWeight.Bold : FontWeight.Regular)
      .fontColor(this.selectedSize === value ? '#FFFFFF' : '#3C4853')
      .padding({ left: 14, right: 14, top: 8, bottom: 8 })
      .backgroundColor(this.selectedSize === value ? '#1C6F63' : '#FFFFFF')
      .borderRadius(18)
      .onClick(() => {
        this.selectedSize = value;
        this.syncMessage = `${label} 卡片预览中`;
      })
  }

  @Builder
  AssetWidgetCard() {
    Column({ space: 14 }) {
      Row() {
        Column({ space: 4 }) {
          Text('资产台账')
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor('#17212B')
          Text('教学设备资产管理')
            .fontSize(12)
            .fontColor('#66727F')
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Text(this.selectedSize)
          .fontSize(12)
          .fontColor('#1C6F63')
          .padding({ left: 10, right: 10, top: 5, bottom: 5 })
          .backgroundColor('#E7F3F0')
          .borderRadius(14)
      }
      .width('100%')

      Row({ space: 10 }) {
        this.MetricTile('资产总数', this.summary.totalCount, '台', '#1C6F63')
        this.MetricTile('维修中', this.summary.repairCount, '台', '#B45F06')
        this.MetricTile('在库', this.summary.inStockCount, '台', '#315D9A')
      }
      .width('100%')

      if (this.selectedSize === '2x4') {
        this.RepairPreview()
      }

      Button('快速进入资产台账')
        .width('100%')
        .height(44)
        .fontSize(15)
        .fontColor('#FFFFFF')
        .backgroundColor('#1C6F63')
        .borderRadius(14)
        .onClick(() => {
          this.syncMessage = '正在打开资产台账';
          router.pushUrl({
            url: 'pages/Index'
          });
        })
    }
    .width('100%')
    .height(this.selectedSize === '2x2' ? 238 : 318)
    .padding(18)
    .backgroundColor('#FFFFFF')
    .borderRadius(22)
    .shadow({ radius: 18, color: '#18000000', offsetY: 6 })
  }

  @Builder
  MetricTile(label: string, value: number, unit: string, color: string) {
    Column({ space: 4 }) {
      Text(`${value}`)
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(color)
      Text(unit)
        .fontSize(11)
        .fontColor('#66727F')
      Text(label)
        .fontSize(12)
        .fontColor('#3C4853')
        .maxLines(1)
    }
    .layoutWeight(1)
    .height(78)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor('#F4F7F8')
    .borderRadius(14)
  }

  @Builder
  RepairPreview() {
    Column({ space: 8 }) {
      Row() {
        Text('待处理资产')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor('#17212B')
        Blank()
        Text(`${this.repairAssets.length} 条`)
          .fontSize(12)
          .fontColor('#B45F06')
      }
      .width('100%')

      if (this.repairAssets.length > 0) {
        Row() {
          Column({ space: 3 }) {
            Text(this.repairAssets[0].assetName)
              .fontSize(13)
              .fontWeight(FontWeight.Medium)
              .fontColor('#17212B')
              .maxLines(1)
            Text(this.repairAssets[0].departmentName)
              .fontSize(11)
              .fontColor('#66727F')
          }
          .alignItems(HorizontalAlign.Start)
          .layoutWeight(1)

          Text('维修中')
            .fontSize(11)
            .fontColor('#B45F06')
            .padding({ left: 9, right: 9, top: 4, bottom: 4 })
            .backgroundColor('#FFF3E0')
            .borderRadius(12)
        }
        .width('100%')
        .padding(10)
        .backgroundColor('#FAFBFC')
        .borderRadius(12)
      } else {
        Text('暂无维修资产')
          .fontSize(12)
          .fontColor('#66727F')
      }
    }
    .width('100%')
  }

  @Builder
  StatsDetail() {
    Row({ space: 10 }) {
      this.DetailBlock('使用中', this.summary.inUseCount, '#1C6F63')
      this.DetailBlock('已报废', this.summary.scrappedCount, '#66727F')
      this.DetailBlock('资产原值', this.summary.totalValue, '#17212B')
    }
    .width('100%')
  }

  @Builder
  DetailBlock(label: string, value: number, color: string) {
    Column({ space: 5 }) {
      Text(label)
        .fontSize(12)
        .fontColor('#66727F')
      Text(label === '资产原值' ? `￥${value}` : `${value}`)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(color)
    }
    .layoutWeight(1)
    .height(72)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor('#FFFFFF')
    .borderRadius(14)
  }

  @Builder
  ActionPanel() {
    Row({ space: 12 }) {
      Button('刷新统计')
        .layoutWeight(1)
        .height(46)
        .fontSize(15)
        .fontColor('#1C6F63')
        .backgroundColor('#E7F3F0')
        .borderRadius(14)
        .onClick(() => {
          this.assets = AssetStore.list();
          this.syncMessage = '统计已刷新';
        })

      Button('返回首页')
        .layoutWeight(1)
        .height(46)
        .fontSize(15)
        .fontColor('#FFFFFF')
        .backgroundColor('#1C6F63')
        .borderRadius(14)
        .onClick(() => {
          router.back();
        })
    }
    .width('100%')
  }
}
