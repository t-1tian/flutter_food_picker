# Member B 交付文档 — 随机抽取核心逻辑与动画效果

## 页面概述

成员 B 负责首页的核心交互逻辑实现，包括随机菜品抽取算法、老虎机滚动动画效果以及标题呼吸脉动动画。这些功能位于 `lib/pages/home_page.dart` 中，是应用最核心的用户体验模块。

---

## 一、功能实现

### 1.1 随机抽取算法

使用 Dart 内置 `Random` 类生成随机索引，从已加载的 100 道菜品列表中抽取一道：

```dart
void _pickRandom() {
  if (_foods.isEmpty) return;
  final random = Random();
  setState(() {
    _currentFood = _foods[random.nextInt(_foods.length)];
  });
}
```

### 1.2 老虎机滚动动画

点击「开始抽啦」按钮后触发老虎机式的快速滚动效果：
- 通过 `_isRolling` 状态标志控制动画启停
- 在滚动期间连续多次随机切换 `_currentFood`，模拟老虎机转轮效果
- 滚动结束后定格到最终选中的菜品
- 动画时长约 1.5 秒，逐渐减速停止

### 1.3 标题呼吸脉动动画

首页标题「今天吃啥」采用 `AnimationController` 实现呼吸脉动效果：
- 使用 `TickerProviderStateMixin` 提供 vsync
- 周期：1800ms，缩放范围：1.0 → 1.03 → 1.0（循环往复）
- 曲线：`Curves.easeInOut` 平滑过渡
- 给静态页面增添生动感

```dart
late final AnimationController _breathController;
late final Animation<double> _breathAnimation;

@override
void initState() {
  super.initState();
  _breathController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1800),
  )..repeat(reverse: true);
  _breathAnimation = Tween<double>(begin: 1.0, end: 1.03).animate(
    CurvedAnimation(parent: _breathController, curve: Curves.easeInOut),
  );
}

@override
void dispose() {
  _breathController.dispose();  // 及时释放资源
  super.dispose();
}
```

---

## 二、状态管理

首页采用 StatefulWidget 管理以下状态变量：

| 变量 | 类型 | 用途 |
|------|------|------|
| `_currentNavIndex` | int | 底部导航栏当前选中项 |
| `_foods` | List\<Food\> | 已加载的完整菜品列表 |
| `_currentFood` | Food? | 当前抽中的菜品（null 表示未抽取） |
| `_status` | LoadStatus | 数据加载状态（idle/loading/success/error/empty） |
| `_errorMessage` | String? | 错误信息 |
| `_isRolling` | bool | 老虎机滚动动画是否进行中 |

---

## 三、文件清单

| 文件 | 说明 |
|------|------|
| `lib/pages/home_page.dart` | 首页完整实现（随机抽取 + 动画 + 状态管理） |

> 注：UI 样式组件（按钮/卡片/底部导航）由成员 A 提供复用；数据层由成员 C 提供支持。

## 四、测试记录

- [x] 点击「开始抽啦」能正确从 100 道菜中随机抽取
- [x] 老虎机滚动动画流畅，最终结果与随机算法一致
- [x] 标题呼吸脉动动画正常循环运行且不卡顿
- [x] 连续点击可重复抽取不同菜品
- [x] 数据未加载完成时按钮处于不可用或提示状态
