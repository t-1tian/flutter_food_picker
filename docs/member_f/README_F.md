# Member F 交付文档 — 仓库管理 & 部署 & 测试

## 概述

成员 F 负责项目的运维保障工作，包括 GitHub 仓库的 Pull Request 审查（Code Review）、Web 端部署与维护、真机运行测试以及 BUG 跟踪修复。作为仓库管理员之一，成员 F 与组长协作确保代码质量和项目可交付性。

---

## 一、Pull Request 审查

### 1.1 审查流程

每位成员完成功能开发后提交 PR，成员 F 负责 review：

| 审查项 | 检查内容 |
|--------|----------|
| 编译检查 | `flutter analyze` 无 warning/error |
| 功能验证 | 核心功能在 Chrome 或真机上正常运行 |
| 代码规范 | 命名、注释、格式符合 Dart/Flutter 风格 |
| 文档完整性 | README / 截图是否齐全 |
| 安全审查 | 无硬编码密钥、无敏感信息泄露 |

### 1.2 已合并的 PR 记录

| PR | 提交者 | 内容 | 状态 |
|----|--------|------|------|
| [A] Home UI and Shared Style System | 成员A | 项目骨架 + 主题系统 + 可复用组件 | ✅ 已合并 |
| [D] 关于我们页面 | 成员D | AboutPage + 底部导航四页切换 | ✅ 已合并 |
| [E] 使用说明 + 隐私合规 | 成员E | GuidePage + PrivacyPage + 合规文档 | ✅ 已合并 |

---

## 二、Web 部署（GitHub Pages）

### 2.1 部署架构

```
main 分支 (源码)
    ↓ flutter build web --release --base-href /flutter_food_picker/
gh-pages 分支 (构建产物)
    ↓ GitHub Pages 自动托管
https://t-1tian.github.io/flutter_food_picker/
```

### 2.2 部署脚本

```bash
# 1. 切换到 main，拉取最新
git checkout main && git pull origin main

# 2. 构建 Web 产物
flutter build web --release --base-href /flutter_food_picker/

# 3. 切换到 gh-pages 分支
git checkout gh-pages

# 4. 清空旧文件，复制新产物
Remove-Item -Path * -Recurse -Force -Exclude .git
Copy-Item -Path "..\build\web\*" -Destination "." -Recurse -Force

# 5. 确保 .nojekyll 存在（禁用 Jekyll 处理）
echo "" > .nojekyll

# 6. 提交并推送
git add .
git commit -m "deploy: 更新 Web 预览"
git push origin gh-pages

# 7. 切回 main
git checkout main
```

### 2.3 部署记录

| 版本 | 部署日期 | 说明 |
|------|----------|------|
| v1.0 | 初始部署 | 首次上线 GitHub Pages |
| v1.2 | 2026-06 | 更新后重新部署，含 100 道菜品数据 |

---

## 三、真机测试

### 3.1 测试设备

| 设备 | 平台 | 测试结果 |
|------|------|----------|
| Android 手机 | 真机（Android） | ✅ 功能正常，布局适配良好 |
| Chrome 浏览器 | Web (GitHub Pages) | ✅ 在线访问正常 |
| Windows 桌面 | Flutter Desktop | ✅ 窗口缩放适配正常 |

### 3.2 测试覆盖的功能模块

- [x] 首页启动加载动画
- [x] 随机抽取功能（老虎机滚动效果）
- [x] 菜品卡片信息展示（菜名/辣度/菜系/主要食材）
- [x] 「再抽啦」连续抽取
- [x] 底部导航栏切换（首页/选菜/指南/关于）
- [x] 关于我们页（项目信息 + 团队名单）
- [x] 使用说明页
- [x] 隐私合规页
- [x] 菜品浏览列表页
- [x] 下拉刷新
- [x] 网络异常状态提示
- [x] 数据为空状态提示

### 3.3 发现并修复的问题

| 问题 | 描述 | 解决方式 |
|------|------|----------|
| Web 资源路径 404 | 未设置 base-href 导致白屏 | 添加 `--base-href /flutter_food_picker/` 参数 |
| Jekyll 忽略文件 | _framework 目录被忽略 | 添加 `.nojekyll` 文件 |
| 多分支冲突 | pubspec.yaml/main.dart 冲突 | 组长手动解决 + 约定公共文件修改流程 |

---

## 四、职责总结

| 工作领域 | 具体任务 |
|----------|----------|
| **Code Review** | 审核 A/B/C/D/E 各分支的 PR，确保代码质量 |
| **Web 部署** | 执行 flutter build web → 推送 gh-pages → 在线预览 |
| **真机测试** | 在 Android 真机上全面测试各功能模块 |
| **BUG 跟进** | 收集测试问题，协调对应成员修复 |
| **仓库维护** | 分支保护规则管理、gh-pages 自动化 |

> 注：成员 F 不直接编写业务功能代码，而是作为项目的「质量守门员」和「交付最后一公里」的保障者。
