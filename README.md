# 🍳 今天吃啥 / What to Eat Today

> **移动应用软件开发实训 — 期末小组作业（2026 春）**  
> **云南大学 · 信息学院 · 计算机科学与技术 2024 级**

<p align="center">
  <strong>一款帮助「选择困难症」用户随机决定今日餐食的 Flutter 跨平台应用</strong>
</p>

---

## 📱 在线预览（无需安装）

👉 **[https://t-1tian.github.io/flutter_food_picker/](https://t-1tian.github.io/flutter_food_picker/)**

支持 Chrome 浏览器、Android 手机、Windows 桌面等多端访问。

---

## 🖼️ 真机运行截图

### 首页 — 点击按钮，随机抽取

![首页](screenshots/01_home.png)

### 抽取结果 — 展示菜名、辣度、菜系、食材

![抽取结果](screenshots/02_result.png)

### 关于我们 — 项目信息与团队名单

![关于我们](screenshots/03_about.png)

### 菜品浏览 — 全部 100 道菜品列表（支持辣度筛选）

![菜品列表](screenshots/04_food_list.png)

### 使用说明 — 操作指引

![使用说明](screenshots/05_guide.png)

### 隐私合规 — 数据安全声明

![隐私合规](screenshots/06_privacy.png)

---

## 💻 技术栈

| 技术 | 版本/说明 |
|------|-----------|
| **开发框架** | Flutter 3.x (Dart) |
| **设计规范** | Material Design 3（种子色 #FF6B6B） |
| **数据格式** | JSON v2.0（100 道菜品，18 个菜系分类） |
| **网络请求** | http 包 + 自定义 LoadResult 四态封装 |
| **部署方式** | GitHub Pages（gh-pages 分支自动托管） |
| **目标平台** | Web、Android、Desktop |

---

## 👥 小组分工（共 7 人）

| 角色 | 姓名 | 学号 | 负责模块 | 交付文档 |
|------|------|------|----------|----------|
| 组长 | 唐一甜 | 20241120103 | 仓库管理、原型设计、报告撰写、PR 合并 | — |
| 成员 A | 蒋亿乐 | 20241060087 | **项目骨架初始化 + Material 3 主题系统 + 可复用 UI 组件库**（17 个文件） | [docs/member_a/](docs/member_a/) |
| 成员 B | 刘昱泽 | 20241120066 | **随机抽取核心算法 + 老虎机滚动动画 + 标题呼吸脉动动画** | [docs/member_b/](docs/member_b/) |
| 成员 C | 王小梅 | 20241060347 | **100 道菜品数据集(v2.0) + ApiService网络层 + FoodRepository数据层** | [docs/member_c/](docs/member_c/) |
| 成员 D | 杨晨曦 | 20241120237 | **关于我们页面(三卡片布局+7人名单) + 底部导航栏四页切换集成** | [docs/member_d/](docs/member_d/) |
| 成员 E | 张蕴洁 | 20241060249 | **使用说明页 + 隐私合规页 + 隐私合规性说明文档**(7 章节) | [docs/member_e/](docs/member_e/) |
| 成员 F | 于昕冉 | 20211170108 | **PR Code Review + GitHub Pages部署 + 真机测试 + BUG跟进** | [docs/member_f/](docs/member_f/) |

> 协作模式：分支开发（dev/A ~ dev/F）→ Pull Request → Code Review → 合并 main → 构建 Web → 推送 gh-pages

---

## 🗂️ 项目结构

```
flutter_food_picker/
├── lib/
│   ├── main.dart                    # 应用入口 + MaterialApp 配置
│   ├── app.dart                     # 底部导航栏 + IndexedStack 四页切换
│   ├── pages/
│   │   ├── home_page.dart           # 首页（随机抽取 + 动画）
│   │   ├── about_page.dart          # 关于我们
│   │   ├── guide_page.dart          # 使用说明
│   │   └── privacy_page.dart        # 隐私合规
│   ├── widgets/                     # 可复用 UI 组件（A 提供）
│   │   ├── app_primary_button.dart  # 统一主按钮
│   │   ├── app_food_card.dart       # 菜品卡片
│   │   └── app_bottom_nav.dart      # 底部导航栏
│   ├── services/                    # 数据服务层（C 提供）
│   │   ├── api_service.dart         # HTTP 请求 + LoadResult 四态封装
│   │   └── food_repository.dart     # Food 模型 + JSON 解析 + 缓存
│   └── theme/                       # 主题系统（A 提供）
│       ├── app_colors.dart          # 统一色彩常量
│       ├── app_text_styles.dart     # 统一文本样式
│       ├── app_spacing.dart         # 统一间距/圆角
│       └── app_theme.dart           # Material 3 主题配置
├── food_list.json                   # 100 道菜品数据（v2.0）
├── docs/                            # 各成员交付文档
│   ├── member_a/                    # 成员 A 交付文档
│   ├── member_b/                    # 成员 B 交付文档
│   ├── member_c/                    # 成员 C 交付文档
│   ├── member_d/                    # 成员 D 交付文档
│   ├── member_e/                    # 成员 E 交付文档
│   ├── member_f/                    # 成员 F 交付文档
│   └── 隐私合规性说明文档.md        # 完整合规声明
├── screenshots/                     # 真机运行截图
├── pubspec.yaml                     # 依赖配置
├── CONTRIBUTING.md                  # 协作指南
├── STRUCTURE.md                     # 目录约定
└── README.md                        # 本文件
```

---

## 🍲 菜品数据概况

| 项目 | 说明 |
|------|------|
| 总数 | **100 道** |
| 版本 | v2.0 |
| 菜系 | 川菜、粤菜、鲁菜、湘菜、浙菜、淮扬菜、闽菜、徽菜、东北菜、小吃、西餐、日料、韩餐、甜品、饮品、食堂、外卖等 **18 类** |
| 辣度 | 不辣 / 微辣 / 中等 / 辣 / 特辣（**5 级枚举**） |
| 字段 | id / name / spicy / cuisine / main_ingredients |

数据来源：GitHub Raw URL 远程加载，本地 assets 回退。

---

## 🚀 快速开始

### 前置要求

- [Flutter SDK](https://flutter.dev/docs/get-started/install) 3.6.0+
- Dart SDK（随 Flutter 自动安装）

### 安装依赖并运行

```bash
# 克隆仓库
git clone https://github.com/t-1tian/flutter_food_picker.git
cd flutter_food_picker

# 安装依赖
flutter pub get

# 运行（Chrome 浏览器）
flutter run -d chrome

# 或运行在 Android 模拟器
flutter run -d emulator

# 或构建 Web 发布版
flutter build web --release --base-href /flutter_food_picker/
```

### 仅预览（无需安装环境）

直接打开在线链接即可体验完整功能：

👉 **[https://t-1tian.github.io/flutter_food_picker/](https://t-1tian.github.io/flutter_food_picker/)**

---

## 📋 核心功能

| 功能 | 描述 |
|------|------|
| 🔀 随机抽取 | 从 100 道菜品中一键随机抽取，老虎机滚动动效 |
| 🃏 菜品展示 | 卡片式展示：菜名 + 辣度标签 + 菜系 + 主要食材 |
| 🔄 连续抽取 | 「再抽啦」支持连续多次抽取不同菜品 |
| 📋 菜品浏览 | 列表形式查看全部可选菜品及辣度筛选 |
| ℹ️ 关于我们 | 项目信息 + 7 人团队成员名单 + 版本号 |
| 📖 使用说明 | 完整操作指引 |
| 🔒 隐私合规 | 数据来源声明 + 隐私政策 + 法律法规引用 |
| 🌐 多端适配 | Web / Android / Desktop 三端正常运行 |

---

## 📌 合规声明

- ✅ **不收集用户隐私信息**
- ✅ **不请求地理位置权限**
- ✅ **不上传任何用户数据**
- ✅ 数据为自行整理的公开测试数据
- ✅ 遵循《网络安全法》《个人信息保护法》等法律法规
- ✅ 详见 [隐私合规性说明文档](docs/%E9%9A%90%E7%A7%81%E5%90%88%E8%A7%84%E6%80%A7%E8%AF%B4%E6%98%8E%E6%96%87%E6%A1%A3.md)

---

## 📎 相关链接

| 链接 | 地址 |
|------|------|
| GitHub 仓库 | https://github.com/t-1tian/flutter_food_picker |
| 在线预览 | https://t-1tian.github.io/flutter_food_picker/ |
| Flutter 官方文档 | https://docs.flutter.dev |
| Material 3 设计规范 | https://m3.material.io |

---

<p align="center">
  <sub>Made with ❤️ by 第三组 — 云南大学信息学院 2024 级</sub>
</p>
