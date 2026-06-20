# HarmonyOS 教学设备资产移动端模块

本目录是“教学设备资产管理系统”的鸿蒙化核心功能模块示例，用于课程作业报告和 DevEco Studio 截图。

## 模块定位

原 Web 系统的核心业务是资产台账管理。本鸿蒙模块选取该核心功能，使用 ArkTS 与 ArkUI 实现手机端资产列表、状态筛选、资产详情和状态更新入口。

## 技术点

- HarmonyOS Stage 模型工程结构。
- ArkTS 声明式开发范式。
- ArkUI 组件：`Navigation`、`List`、`ListItem`、`TextInput`、`Button`、`ForEach`。
- 移动端交互：关键字搜索、状态筛选、详情查看、状态切换。
- 可扩展方向：通过 `@ohos.net.http` 对接后端资产接口；通过万能卡片展示待维修/在库统计。

## DevEco Studio 使用方式

1. 打开 DevEco Studio。
2. 新建 Empty Ability 工程。
3. 将 `entry/src/main/ets/pages/Index.ets`、`AssetDetail.ets` 和 `common/AssetModel.ets` 复制到新工程相同目录。
4. 在 `entry/src/main/module.json5` 中确认 `pages` 包含 `pages/Index` 和 `pages/AssetDetail`。
5. 使用 Previewer 或模拟器运行并截图。

## 报告截图内容

报告中需要展示：

1. DevEco Studio 工程结构。
2. ArkTS 页面代码。
3. ArkUI 预览或模拟器首页。
4. 搜索与状态筛选。
5. 资产详情页。
6. 状态更新交互。
