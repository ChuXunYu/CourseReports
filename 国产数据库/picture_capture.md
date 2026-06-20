# 国产数据库作业报告截图要求

本文件给队员截图使用。最终报告需要使用真实运行 KingbaseES 和 Web 系统后的截图，不要只截代码，也不要使用占位图。截图统一放入项目目录下的 `report_screenshots` 文件夹，文件名必须和本文一致。

## 一、截图前准备

1. 安装并启动 KingbaseES（金仓数据库）。
2. 创建数据库 `course_assets`。
3. 在项目目录 `D:\Desktop\work\实训\国产数据库` 启动项目：

```powershell
mvn spring-boot:run
```

如果数据库连接信息不同，先设置环境变量：

```powershell
$env:KINGBASE_URL="jdbc:kingbase8://localhost:54321/course_assets"
$env:KINGBASE_USERNAME="system"
$env:KINGBASE_PASSWORD="manager"
mvn spring-boot:run
```

4. 浏览器访问 `http://localhost:8080/assets`。
5. 截图建议使用 1920×1080 或接近 16:9 的窗口，浏览器缩放保持 90% 或 100%。
6. 截图时请避开数据库密码、真实个人账号、内网敏感地址等信息。

## 二、截图清单

### 图 1 KingbaseES 中创建 4 张业务数据表

文件名：`fig01_kingbase_tables.png`

进入 KingbaseES 数据库管理工具或 SQL 命令窗口，连接 `course_assets` 数据库。截图中必须能看到以下 4 张表：

1. `kb_department`
2. `kb_asset_category`
3. `kb_supplier`
4. `kb_asset`

推荐方式：打开数据库对象树中的表列表，或执行查询：

```sql
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public'
  AND table_name LIKE 'kb_%'
ORDER BY table_name;
```

截图范围：数据库连接名、SQL 查询结果或表列表区域。

### 图 2 Spring Boot 项目启动并连接金仓数据库

文件名：`fig02_project_startup.png`

在项目目录执行：

```powershell
mvn spring-boot:run
```

等待项目启动成功。截图中应能看到以下内容之一：

1. `Tomcat started on port 8080`
2. `Started KingbaseAssetApplication`
3. `schema.sql`、`data.sql` 初始化日志

截图范围：终端窗口中项目启动成功的关键日志。

### 图 3 教学设备资产列表页面

文件名：`fig03_asset_list.png`

打开浏览器访问：

```text
http://localhost:8080/assets
```

截图中应能看到：

1. 页面标题“教学设备资产管理”
2. 资产列表表头
3. 至少 2 条资产数据
4. “新增资产”“修改”“删除”等按钮或链接

截图范围：浏览器主体页面，不需要截整个桌面。

### 图 4 按条件查询资产记录

文件名：`fig04_asset_search.png`

在资产列表页面输入关键字，或选择分类、状态后点击“查询”。建议使用：

1. 关键字：`服务器`
2. 分类：`计算机设备`
3. 状态：`使用中`

截图中应能看到查询条件和筛选后的结果。

截图范围：查询栏和结果列表必须同时出现。

### 图 5 新增教学设备资产

文件名：`fig05_asset_create.png`

在列表页点击“新增资产”，进入新增页面。填写一条新资产，例如：

1. 资产编号：`ASSET-2026-003`
2. 资产名称：`数据库课程演示终端`
3. 设备分类：`计算机设备`
4. 使用部门：`软件实训室`
5. 供应商：任选已有供应商
6. 状态：`在库`
7. 保管人：填写队员姓名或“实训管理员”

截图建议：提交前截完整表单；如果已经提交，也可以截提交成功后的列表页，但要能看到新增的数据。

截图范围：表单字段尽量完整显示。

### 图 6 修改资产信息

文件名：`fig06_asset_update.png`

在列表页选择一条资产，点击“修改”。进入编辑页面后，修改状态、保管人或备注，例如把状态改为“使用中”，备注改为“用于国产数据库实训演示”。

截图中应能看到：

1. 页面标题“修改教学设备”
2. 资产编号和资产名称
3. 被修改的字段
4. “更新资产”按钮

截图范围：编辑表单主体。

### 图 7 删除资产后列表更新

文件名：`fig07_asset_delete.png`

在列表页选择刚才新增或测试用的一条资产，点击“删除”并确认。删除后截图列表页面。

截图中应能看到：

1. 删除成功提示，或
2. 目标记录已经不在列表中

注意：不要只截浏览器确认弹窗；最终截图应以删除后的列表页面为主。

### 图 8 数据库中资产数据与 Web 操作保持一致

文件名：`fig08_database_result.png`

回到 KingbaseES 查询工具，执行：

```sql
SELECT asset_code, asset_name, status, keeper, remark
FROM kb_asset
ORDER BY id DESC;
```

截图中应能看到 Web 端新增或修改后的资产记录。如果图 7 已删除该记录，则可以查询仍存在的修改记录，或重新新增一条用于核对。

截图范围：SQL 语句和查询结果区域。

## 三、提交给我的文件

请把 8 张图片放入：

```text
D:\Desktop\work\实训\国产数据库\report_screenshots
```

最终应包含：

1. `fig01_kingbase_tables.png`
2. `fig02_project_startup.png`
3. `fig03_asset_list.png`
4. `fig04_asset_search.png`
5. `fig05_asset_create.png`
6. `fig06_asset_update.png`
7. `fig07_asset_delete.png`
8. `fig08_database_result.png`

文件名必须一致，方便自动替换到 Word 报告中。
