import router from '@ohos.router';
import { AssetStatus, AssetStatusMapper } from '../common/AssetModel';
import { AssetStore, AssetDraft } from '../common/AssetStore';

@Entry
@Component
struct AddAsset {
  @State assetCode: string = '';
  @State assetName: string = '';
  @State categoryName: string = '计算机设备';
  @State departmentName: string = '';
  @State supplierName: string = '';
  @State keeper: string = '';
  @State originalValue: string = '';
  @State remark: string = '';
  @State status: AssetStatus = 'IN_STOCK';
  @State message: string = '填写后点击保存，设备会立即显示在资产台账中';

  build() {
    Navigation() {
      Scroll() {
        Column({ space: 14 }) {
          this.FormHeader()
          this.InputField('资产编号', '不填则自动生成', this.assetCode, 'assetCode')
          this.InputField('设备名称', '例如：实训室投影仪', this.assetName, 'assetName')
          this.CategoryPanel()
          this.InputField('使用部门', '例如：软件实训室', this.departmentName, 'departmentName')
          this.InputField('供应商', '例如：教学设备有限公司', this.supplierName, 'supplierName')
          this.InputField('保管人', '例如：张老师', this.keeper, 'keeper')
          this.InputField('资产原值', '例如：5800', this.originalValue, 'originalValue')
          this.StatusPanel()
          this.InputField('备注', '填写设备用途或维护说明', this.remark, 'remark')
          this.ActionButtons()
        }
        .width('100%')
        .padding({ left: 20, right: 20, top: 18, bottom: 24 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F4F7F8')
    }
    .title('新增设备')
    .mode(NavigationMode.Stack)
  }

  @Builder
  FormHeader() {
    Column({ space: 6 }) {
      Text('新增教学设备')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor('#17212B')
      Text(this.message)
        .fontSize(13)
        .fontColor(this.message.indexOf('失败') >= 0 || this.message.indexOf('请输入') >= 0 || this.message.indexOf('已存在') >= 0 ? '#B45F06' : '#66727F')
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }

  @Builder
  InputField(label: string, placeholder: string, text: string, fieldName: string) {
    Column({ space: 7 }) {
      Text(label)
        .fontSize(13)
        .fontColor('#66727F')
      TextInput({ placeholder: placeholder, text: text })
        .height(44)
        .fontSize(15)
        .backgroundColor('#FFFFFF')
        .borderRadius(12)
        .padding({ left: 12, right: 12 })
        .onChange((value: string) => {
          this.updateField(fieldName, value);
        })
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }

  @Builder
  CategoryPanel() {
    Column({ space: 8 }) {
      Text('设备分类')
        .fontSize(13)
        .fontColor('#66727F')
      Row({ space: 9 }) {
        this.CategoryPill('计算机设备')
        this.CategoryPill('网络设备')
        this.CategoryPill('教学设备')
      }
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }

  @Builder
  CategoryPill(value: string) {
    Text(value)
      .fontSize(13)
      .fontWeight(this.categoryName === value ? FontWeight.Bold : FontWeight.Regular)
      .fontColor(this.categoryName === value ? '#FFFFFF' : '#3C4853')
      .padding({ left: 13, right: 13, top: 8, bottom: 8 })
      .backgroundColor(this.categoryName === value ? '#1C6F63' : '#FFFFFF')
      .borderRadius(18)
      .onClick(() => {
        this.categoryName = value;
      })
  }

  @Builder
  StatusPanel() {
    Column({ space: 8 }) {
      Text('当前状态')
        .fontSize(13)
        .fontColor('#66727F')
      Row({ space: 9 }) {
        this.StatusPill('IN_STOCK')
        this.StatusPill('IN_USE')
        this.StatusPill('REPAIR')
      }
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }

  @Builder
  StatusPill(value: AssetStatus) {
    Text(AssetStatusMapper.label(value))
      .fontSize(13)
      .fontWeight(this.status === value ? FontWeight.Bold : FontWeight.Regular)
      .fontColor(this.status === value ? '#FFFFFF' : '#3C4853')
      .padding({ left: 13, right: 13, top: 8, bottom: 8 })
      .backgroundColor(this.status === value ? '#1C6F63' : '#FFFFFF')
      .borderRadius(18)
      .onClick(() => {
        this.status = value;
      })
  }

  @Builder
  ActionButtons() {
    Column({ space: 10 }) {
      Button('保存设备')
        .width('100%')
        .height(48)
        .fontSize(16)
        .fontColor('#FFFFFF')
        .backgroundColor('#1C6F63')
        .borderRadius(14)
        .onClick(() => {
          this.saveAsset();
        })

      Button('取消')
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
    .margin({ top: 6 })
  }

  private saveAsset() {
    const value = Number(this.originalValue);
    const draft: AssetDraft = {
      assetCode: this.assetCode,
      assetName: this.assetName,
      categoryName: this.categoryName,
      departmentName: this.departmentName,
      supplierName: this.supplierName,
      status: this.status,
      keeper: this.keeper,
      originalValue: isNaN(value) ? 0 : value,
      remark: this.remark
    };

    const result = AssetStore.add(draft);
    this.message = result.message;
    if (result.success) {
      router.back();
    }
  }

  private updateField(fieldName: string, value: string) {
    if (fieldName === 'assetCode') {
      this.assetCode = value;
    } else if (fieldName === 'assetName') {
      this.assetName = value;
    } else if (fieldName === 'departmentName') {
      this.departmentName = value;
    } else if (fieldName === 'supplierName') {
      this.supplierName = value;
    } else if (fieldName === 'keeper') {
      this.keeper = value;
    } else if (fieldName === 'originalValue') {
      this.originalValue = value;
    } else if (fieldName === 'remark') {
      this.remark = value;
    }
  }
}
