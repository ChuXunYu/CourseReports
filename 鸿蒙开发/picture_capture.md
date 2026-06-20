# 鸿蒙开发作业报告截图要求

本文件给队员截图使用。最终报告需要使用 DevEco Studio、Previewer 或模拟器中的真实截图，不要只截占位图。截图统一放入 `D:\Desktop\work\实训\鸿蒙开发\report_screenshots`，文件名必须和本文一致。

## 一、截图前准备

1. 安装 HUAWEI DevEco Studio 和 HarmonyOS SDK。
2. 打开或新建 HarmonyOS Empty Ability 工程。
3. 将 `HarmonyAssetModule` 中的 `Index.ets`、`AssetDetail.ets`、`AssetModel.ets` 放入新工程对应目录。
4. 确认 `module.json5` 或 `main_pages.json` 包含：

```json
{
  "src": [
    "pages/Index",
    "pages/AssetDetail"
  ]
}
```

5. 使用 Previewer 或模拟器运行页面。
6. 截图时请尽量使用清晰窗口，避免截入个人账号、无关聊天窗口等信息。

## 二、截图清单与点击路径

### 图 1 DevEco Studio 中的鸿蒙工程结构

文件名：`fig01_deveco_project.png`

点击路径：

1. 打开 DevEco Studio。
2. 选择 `Open Project`，打开 `HarmonyAssetModule` 或队员新建后复制代码的鸿蒙工程。
3. 在左侧 Project 视图中展开 `entry/src/main/ets`。
4. 点击 `entry/src/main/module.json5` 或 `entry/src/main/ets/pages/Index.ets`。
5. 截取包含左侧工程树和中间编辑区的完整窗口。

画面需要包含：

1. `entry` 模块
2. `ets/pages`
3. `Index.ets`
4. `AssetDetail.ets`
5. `common/AssetModel.ets` 或 `module.json5`

采集目的：让报告读者能看出本模块采用 HarmonyOS/ArkTS 工程结构。

### 图 2 使用 ArkTS 与 ArkUI 编写资产列表页面

文件名：`fig02_arkts_index_code.png`

点击路径：

1. 在 DevEco Studio 左侧工程树展开 `entry/src/main/ets/pages`。
2. 点击打开 `Index.ets`。
3. 将编辑器滚动到包含 `@Entry`、`@Component`、`@State`、`Navigation`、`List` 或 `ForEach` 的位置。
4. 截取代码编辑区，左侧工程树可以保留在画面中。

文件路径：

```text
entry/src/main/ets/pages/Index.ets
```

截图中应能看到：

1. `@Entry`
2. `@Component`
3. `@State`
4. `Navigation`
5. `List` 或 `ForEach`
6. `TextInput`

采集目的：展示 ArkTS 声明式 UI 代码和资产列表实现。

### 图 3 资产台账鸿蒙端首页预览

文件名：`fig03_home_preview.png`

点击路径：

1. 打开 `Index.ets`。
2. 点击 DevEco Studio 右侧或上方的 `Previewer`。
3. 如果 Previewer 未自动刷新，点击刷新按钮；也可以点击运行按钮启动模拟器。
4. 等首页加载完成后截图。

画面需要包含：

1. 标题“教学设备资产”或“资产台账”
2. 搜索框
3. 状态筛选按钮
4. 至少两张资产卡片

采集目的：展示核心业务模块已经转换为鸿蒙手机端页面。

### 图 4 鸿蒙端资产搜索与状态筛选

文件名：`fig04_search_filter.png`

点击路径：

1. 在首页预览或模拟器中点击搜索框。
2. 输入关键字，例如 `服务器`。
3. 或点击状态筛选按钮，例如 `使用中` / `维修中`。
4. 等列表内容变化后截图。

截图中应同时包含筛选条件和筛选后的资产列表。

采集目的：对应原系统中的资产查询功能，同时体现移动端触屏筛选方式。

### 图 5 资产详情页面

文件名：`fig05_asset_detail.png`

点击路径：

1. 回到首页预览或模拟器。
2. 点击任意一张资产卡片。
3. 页面跳转到 `资产详情` 后截图。

画面需要包含：

1. 资产名称
2. 资产编号
3. 当前状态
4. 分类
5. 使用部门
6. 供应商
7. 保管人
8. 备注

采集目的：展示移动端详情查看功能。

### 图 6 移动端资产状态更新交互

文件名：`fig06_status_update.png`

点击路径：

1. 在详情页找到按钮：

```text
标记为使用中
```

2. 点击该按钮。
3. 等页面上的“当前状态”字段变为“使用中”后截图。

采集目的：展示鸿蒙端不仅能查看资产，也能进行轻量级业务维护。

### 图 7 手机和平板预览体现一次开发多端部署

文件名：`fig07_multi_device_preview.png`

点击路径：

1. 打开 `Index.ets`。
2. 打开 Previewer。
3. 在 Previewer 设备选择处先选择手机设备并截图。
4. 再切换到平板设备预览并截图。
5. 如果方便，请把手机和平板两张预览拼在同一张图里；如果不方便，优先提交手机预览，文件名仍使用 `fig07_multi_device_preview.png`。

截图中应能看到同一页面在不同屏幕上的展示。

采集目的：体现 HarmonyOS “一次开发，多端部署”的思路。

### 图 8 万能卡片或元服务扩展设计

文件名：`fig08_widget_design.png`

点击路径：

方案 A：如果队员会创建卡片

1. 在 DevEco Studio 中创建或打开 Form/Widget 相关页面。
2. 设计资产统计卡片。
3. 打开卡片预览并截图。

方案 B：如果暂时没有实现卡片

1. 用 DevEco Studio、画图工具或原型工具画一个简单卡片草图。
2. 卡片标题建议写“资产台账”。
3. 截取卡片原型画面。

画面建议包含：

1. 资产总数
2. 维修中数量
3. 在库数量
4. 快速进入资产台账按钮

采集目的：体现 HarmonyOS 服务直达、减少操作层级的设计思想。

## 三、最终交给我的图片清单

请把以下 8 张图片放入：

```text
D:\Desktop\work\实训\鸿蒙开发\report_screenshots
```

文件名如下：

1. `fig01_deveco_project.png`
2. `fig02_arkts_index_code.png`
3. `fig03_home_preview.png`
4. `fig04_search_filter.png`
5. `fig05_asset_detail.png`
6. `fig06_status_update.png`
7. `fig07_multi_device_preview.png`
8. `fig08_widget_design.png`

文件名必须一致，后续会自动替换到 Word 报告中。
