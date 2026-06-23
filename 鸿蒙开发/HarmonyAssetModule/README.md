# HarmonyOS 教学设备资产移动端模块

本目录是“教学设备资产管理系统”的鸿蒙化核心功能模块示例，用于课程作业报告和 DevEco Studio 截图。

## 模块定位

原 Web 系统的核心业务是资产台账管理。本鸿蒙模块选取该核心功能，使用 ArkTS 与 ArkUI 实现手机端资产列表、状态筛选、新增设备、资产详情和状态更新入口。

## 技术点

- HarmonyOS Stage 模型工程结构。
- ArkTS 声明式开发范式。
- ArkUI 组件：`Navigation`、`List`、`ListItem`、`TextInput`、`Button`、`ForEach`。
- 移动端交互：关键字搜索、状态筛选、新增设备、详情查看、状态切换。
- 本地数据仓库：通过 `AssetStore.ets` 统一管理演示数据，页面返回时自动刷新列表，避免新增后不显示。
- 万能卡片/元服务扩展：通过 `AssetCardFormAbility.ets`、`AssetCardWidget.ets` 和 `form_config.json` 注册真实 HarmonyOS 外部卡片，展示资产总数、维修中、在库数量和快速进入资产台账入口。
- 应用内预览页：`WidgetDesign.ets` 用于课程报告截图演示卡片设计，真实系统卡片入口在 `ets/widget/pages/AssetCardWidget.ets`。
- 可扩展方向：通过 `@ohos.data.relationalStore` 或 `@ohos.net.http` 对接真实资产数据库/后端接口，并在卡片刷新时同步统计数据。

## DevEco Studio 使用方式

1. 打开 DevEco Studio。
2. 新建 Empty Ability 工程。
3. 将 `entry/src/main/ets/pages/Index.ets`、`AddAsset.ets`、`AssetDetail.ets`、`WidgetDesign.ets`、`common/AssetModel.ets`、`common/AssetStore.ets`、`formability/AssetCardFormAbility.ets`、`widget/pages/AssetCardWidget.ets` 和 `resources/base/profile/form_config.json` 复制到新工程相同目录。
4. 在 `entry/src/main/module.json5` 中确认 `pages` 包含 `pages/Index`、`pages/AddAsset`、`pages/AssetDetail` 和 `pages/WidgetDesign`。
5. 在 `entry/src/main/module.json5` 中确认 `extensionAbilities` 包含 `AssetCardFormAbility`，并且 `metadata` 指向 `$profile:form_config`。
6. 使用 Previewer 或模拟器运行并截图。真实卡片可在 DevEco 的卡片预览中打开 `AssetCardWidget.ets`，或安装到设备后从桌面/服务中心添加“资产台账卡片”。

## 报告截图内容

报告中需要展示：

1. DevEco Studio 工程结构。
2. ArkTS 页面代码。
3. ArkUI 预览或模拟器首页。
4. 搜索与状态筛选。
5. 资产详情页。
6. 状态更新交互。
7. 手机和平板预览。
8. 万能卡片/元服务扩展设计：优先打开真实卡片 `widget/pages/AssetCardWidget` 或在设备桌面添加“资产台账卡片”截图；也可从首页点击“万能卡片 / 元服务预览”进入应用内设计预览，文件名使用 `fig08_widget_design.png`。
