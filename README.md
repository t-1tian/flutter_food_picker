# 今天吃啥 · Flutter 期末项目

> 移动应用软件开发实训 · 第三组 · 期末作业

一款轻量、随机、好看的「今天吃啥」决策小助手——点一下按钮，从 50+ 道菜品里随机抽一个，让你每天的「世纪难题」瞬间有解。

## 项目信息

| 项目 | 内容 |
|------|------|
| 项目名称 | 今天吃啥（Random Food Picker）|
| 小组 | 第三组 |
| 课程 | 移动应用软件开发实训 |
| 学期 | 2026 春 |
| 仓库 | https://gitee.com/svtyt/flutter_food_picker.git |
| 技术栈 | Flutter / Dart / Material Design |

## 团队分工

| 角色 | 同学 | 分支 | 主要职责 |
|------|------|------|----------|
| 组长 | 组长 | `dev/maintainer` | 实验报告 / 原型图 / 资源汇总 |
| 成员 A | A | `dev/A` | 界面设计（配色、字体、图标、通用样式）|
| 成员 B | B | `dev/B` | 随机抽取核心功能 + 交互动效 |
| 成员 C | C | `dev/C` | `food_list.json` 数据 + 网络请求 + JSON 解析 |
| 成员 D | D | `dev/D` | 「关于我们」页面 + 路由跳转 |
| 成员 E | E | `dev/E` | 使用说明页 + 隐私合规页 + 跳转 |
| 成员 F | F | `dev/F` | 仓库管理员 / 分支管理 / 真机测试 / BUG 跟进 |

## 分支策略

```
main                ← 受保护分支，由 F 同学 review 后合并
dev/A, dev/B, ...   ← 每位成员在自己的开发分支上工作
```

**协作流程：**
1. 在自己的分支上 `git add .` → `git commit -m "..."` → `git push origin dev/X`
2. 在 Gitee 上提交 **Pull Request**，标题写明功能
3. 等 F 同学 review 通过后合并到 main

## 目录结构

```
flutter_food_picker/
├── lib/
│   ├── main.dart               # 入口
│   ├── pages/                  # 各页面
│   │   ├── home_page.dart      # 首页
│   │   ├── about_page.dart     # 关于我们
│   │   ├── guide_page.dart     # 使用说明
│   │   └── privacy_page.dart   # 隐私合规
│   ├── widgets/                # 通用组件
│   ├── services/               # 网络请求、JSON 解析
│   └── theme/                  # 全局样式
├── assets/
│   └── food_list.json          # 菜品数据（由 C 同学维护）
├── pubspec.yaml
└── README.md
```

## 功能列表

- [ ] 首页：随机按钮 + 当前菜品展示 + 动效
- [ ] 50+ 道菜品数据（在线 JSON）
- [ ] 使用说明页
- [ ] 隐私合规声明
- [ ] 关于我们页（项目名 / 成员 / 版本）
- [ ] 加载中 / 网络异常 / 数据为空 三种提示
- [ ] 全局统一样式（按钮 / 文本 / 卡片）
- [ ] 多端适配（不同手机尺寸无错位）

## 本地运行

```bash
flutter pub get
flutter run -d chrome        # Chrome 调试
flutter run -d <设备ID>      # 真机调试
```

## Flutter SDK

| 项 | 值 |
|----|----|
| Channel | stable |
| Version | 3.41.7+ |
| Dart | 3.x |

## 隐私与合规

- 本应用不收集任何用户隐私
- 不获取地理位置
- 所有餐饮数据均为公开测试数据
- 符合网络安全与隐私规范

## 提交规范

Commit message 建议使用以下前缀：
- `feat:` 新功能
- `fix:` 修复 BUG
- `docs:` 文档变更
- `style:` 样式调整
- `refactor:` 重构
- `chore:` 构建/工具变动

例如：`feat: 首页随机按钮点击动效`

## 仓库管理员

- 仓库地址：https://gitee.com/svtyt/flutter_food_picker
- 管理员：F 同学
- BUG 反馈：在 Gitee Issues 中提交
