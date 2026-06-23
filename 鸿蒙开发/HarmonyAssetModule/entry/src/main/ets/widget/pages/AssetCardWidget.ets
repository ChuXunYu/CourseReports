import { postCardAction } from '@kit.ArkUI';

@Entry
@Component
struct AssetCardWidget {
  @LocalStorageProp('totalCount') totalCount: number = 0;
  @LocalStorageProp('repairCount') repairCount: number = 0;
  @LocalStorageProp('inStockCount') inStockCount: number = 0;
  @LocalStorageProp('inUseCount') inUseCount: number = 0;
  @LocalStorageProp('title') title: string = '资产台账';
  @LocalStorageProp('description') description: string = '教学设备资产统计';

  build() {
    Column({ space: 10 }) {
      Row() {
        Column({ space: 3 }) {
          Text(this.title)
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#17212B')
            .maxLines(1)
          Text(this.description)
            .fontSize(11)
            .fontColor('#66727F')
            .maxLines(1)
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Text('鸿蒙卡片')
          .fontSize(10)
          .fontColor('#1C6F63')
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .backgroundColor('#E7F3F0')
          .borderRadius(10)
      }
      .width('100%')

      Row({ space: 8 }) {
        this.MetricItem('总数', this.totalCount, '#1C6F63')
        this.MetricItem('维修', this.repairCount, '#B45F06')
        this.MetricItem('在库', this.inStockCount, '#315D9A')
      }
      .width('100%')
      .layoutWeight(1)

      Row() {
        Text(`使用中 ${this.inUseCount} 台`)
          .fontSize(11)
          .fontColor('#66727F')
        Blank()
        Text('进入台账')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFFFFF')
          .padding({ left: 10, right: 10, top: 5, bottom: 5 })
          .backgroundColor('#1C6F63')
          .borderRadius(12)
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .padding(12)
    .backgroundColor('#FFFFFF')
    .borderRadius(18)
    .onClick(() => {
      postCardAction(this, {
        action: 'router',
        abilityName: 'EntryAbility',
        params: {
          target: 'AssetLedger'
        }
      });
    })
  }

  @Builder
  MetricItem(label: string, value: number, color: string) {
    Column({ space: 2 }) {
      Text(`${value}`)
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(color)
        .maxLines(1)
      Text(label)
        .fontSize(10)
        .fontColor('#66727F')
        .maxLines(1)
    }
    .layoutWeight(1)
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor('#F4F7F8')
    .borderRadius(12)
  }
}
