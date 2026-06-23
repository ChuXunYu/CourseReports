import router from '@ohos.router';
import { AssetItem, AssetStatusMapper, buildAssetSummary } from '../common/AssetModel';
import { AssetStore } from '../common/AssetStore';

@Entry
@Component
struct Index {
  @State keyword: string = '';
  @State selectedStatus: string = 'ALL';
  @State assets: AssetItem[] = AssetStore.list();

  aboutToAppear() {
    this.assets = AssetStore.list();
  }

  private get filteredAssets(): AssetItem[] {
    return this.assets.filter((item: AssetItem) => {
      const keywordMatched = this.keyword.trim().length === 0
        || item.assetCode.includes(this.keyword.trim())
        || item.assetName.includes(this.keyword.trim())
        || item.departmentName.includes(this.keyword.trim())
        || item.keeper.includes(this.keyword.trim());
      const statusMatched = this.selectedStatus === 'ALL' || item.status === this.selectedStatus;
      return keywordMatched && statusMatched;
    });
  }

  build() {
    Navigation() {
      Column({ space: 18 }) {
        this.HeaderSummary()
        this.AddAssetEntry()
        this.WidgetEntry()
        this.SearchPanel()
        this.StatusFilter()
        if (this.filteredAssets.length > 0) {
          List({ space: 12 }) {
            ForEach(this.filteredAssets, (asset: AssetItem) => {
              ListItem() {
                this.AssetCard(asset)
              }
            }, (asset: AssetItem) => asset.assetCode)
          }
          .layoutWeight(1)
          .scrollBar(BarState.Off)
        } else {
          this.EmptyState()
        }
      }
      .width('100%')
      .height('100%')
      .padding({ left: 20, right: 20, top: 18, bottom: 12 })
      .backgroundColor('#F4F7F8')
    }
    .title('教学设备资产')
    .mode(NavigationMode.Stack)
  }

  @Builder
  AddAssetEntry() {
    Button('新增设备')
      .width('100%')
      .height(44)
      .fontSize(16)
      .fontColor('#FFFFFF')
      .backgroundColor('#1C6F63')
      .borderRadius(14)
      .onClick(() => {
        this.keyword = '';
        this.selectedStatus = 'ALL';
        router.pushUrl({
          url: 'pages/AddAsset'
        });
      })
  }

  @Builder
  HeaderSummary() {
    Row() {
      Column() {
        Text('资产台账')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#17212B')
        Text('HarmonyOS 移动端核心模块')
          .fontSize(14)
          .fontColor('#66727F')
          .margin({ top: 6 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Column() {
        Text(`${buildAssetSummary(this.assets).totalCount}`)
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFFFFF')
        Text('总资产')
          .fontSize(12)
          .fontColor('#DFF3EF')
      }
      .width(92)
      .height(70)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .backgroundColor('#1C6F63')
      .borderRadius(18)
    }
    .width('100%')
  }

  @Builder
  WidgetEntry() {
    Column({ space: 10 }) {
      Column({ space: 4 }) {
        Text('万能卡片 / 元服务预览')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#17212B')
        Text(`维修中 ${buildAssetSummary(this.assets).repairCount} 台 · 在库 ${buildAssetSummary(this.assets).inStockCount} 台`)
          .fontSize(12)
          .fontColor('#66727F')
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')

      Button('万能卡片 / 元服务预览')
        .width('100%')
        .height(40)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor('#FFFFFF')
        .backgroundColor('#1C6F63')
        .borderRadius(18)
        .onClick(() => {
          router.pushUrl({
            url: 'pages/WidgetDesign'
          });
        })
    }
    .width('100%')
    .padding(14)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
    .shadow({ radius: 10, color: '#10000000', offsetY: 3 })
    .onClick(() => {
      router.pushUrl({
        url: 'pages/WidgetDesign'
      });
    })
  }

  @Builder
  SearchPanel() {
    Row() {
      TextInput({ placeholder: '搜索编号、名称、部门或保管人', text: this.keyword })
        .height(46)
        .fontSize(15)
        .backgroundColor('#FFFFFF')
        .borderRadius(12)
        .padding({ left: 14, right: 14 })
        .onChange((value: string) => {
          this.keyword = value;
        })
    }
    .width('100%')
  }

  @Builder
  StatusFilter() {
    Row({ space: 10 }) {
      this.StatusPill('ALL', '全部')
      this.StatusPill('IN_STOCK', '在库')
      this.StatusPill('IN_USE', '使用中')
      this.StatusPill('REPAIR', '维修中')
    }
    .width('100%')
  }

  @Builder
  StatusPill(value: string, label: string) {
    Text(label)
      .fontSize(14)
      .fontWeight(this.selectedStatus === value ? FontWeight.Bold : FontWeight.Regular)
      .fontColor(this.selectedStatus === value ? '#FFFFFF' : '#3C4853')
      .padding({ left: 14, right: 14, top: 8, bottom: 8 })
      .backgroundColor(this.selectedStatus === value ? '#1C6F63' : '#FFFFFF')
      .borderRadius(20)
      .onClick(() => {
        this.selectedStatus = value;
      })
  }

  @Builder
  EmptyState() {
    Column({ space: 10 }) {
      Text('暂无匹配设备')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#17212B')
      Text('请清空搜索条件，或点击新增设备录入资产')
        .fontSize(13)
        .fontColor('#66727F')
      Button('新增设备')
        .width('100%')
        .height(42)
        .fontSize(15)
        .fontColor('#FFFFFF')
        .backgroundColor('#1C6F63')
        .borderRadius(14)
        .onClick(() => {
          this.keyword = '';
          this.selectedStatus = 'ALL';
          router.pushUrl({
            url: 'pages/AddAsset'
          });
        })
    }
    .width('100%')
    .layoutWeight(1)
    .justifyContent(FlexAlign.Center)
    .padding(18)
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
  }

  @Builder
  AssetCard(asset: AssetItem) {
    Column({ space: 12 }) {
      Row() {
        Column() {
          Text(asset.assetName)
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#17212B')
          Text(asset.assetCode)
            .fontSize(13)
            .fontColor('#66727F')
            .margin({ top: 4 })
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Text(AssetStatusMapper.label(asset.status))
          .fontSize(12)
          .fontColor('#1C6F63')
          .backgroundColor('#E7F3F0')
          .padding({ left: 10, right: 10, top: 5, bottom: 5 })
          .borderRadius(14)
      }
      Row() {
        Text(asset.categoryName)
          .fontSize(13)
          .fontColor('#415160')
        Blank()
        Text(asset.departmentName)
          .fontSize(13)
          .fontColor('#415160')
      }
      Row() {
        Text(`保管人：${asset.keeper}`)
          .fontSize(13)
          .fontColor('#66727F')
        Blank()
        Text(`￥${asset.originalValue}`)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor('#17212B')
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(18)
    .shadow({ radius: 12, color: '#14000000', offsetY: 4 })
    .onClick(() => {
      router.pushUrl({
        url: 'pages/AssetDetail',
        params: asset
      });
    })
  }
}
