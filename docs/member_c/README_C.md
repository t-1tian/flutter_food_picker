# Member C 交付文档 — 数据层（菜品数据 + 网络请求 + JSON 解析）

## 概述

成员 C 负责项目的全部数据相关工作，包括菜品数据集编写、网络请求服务层封装、数据解析与模型定义。数据层采用三层架构：**ApiService（网络）→ FoodRepository（数据）→ UI 层**，确保职责清晰、易于测试。

---

## 一、菜品数据集（food_list.json v2.0）

### 1.1 数据概况

| 项目 | 说明 |
|------|------|
| 版本号 | v2.0 |
| 更新日期 | 2026-06-15 |
| 菜品总数 | **100 道** |
| 菜系覆盖 | **18 个分类** |
| 辣度分级 | 5 级（不辣 / 微辣 / 中等 / 辣 / 特辣） |
| 每条字段数 | 5 个（id / name / spicy / cuisine / main_ingredients） |

### 1.2 菜系分布

| 菜系 | 数量 | 代表菜品 |
|------|------|----------|
| 川菜 | 9 | 宫保鸡丁、麻婆豆腐、水煮鱼、回锅肉... |
| 食堂/快餐 | 25 | 黄焖鸡米饭、麻辣烫、红烧排骨饭... |
| 小吃 | 14 | 兰州拉面、螺蛳粉、煎饼果子... |
| 粤菜 | 5 | 白切鸡、烧鹅、广式早茶虾饺... |
| 西餐 | 6 | 黑椒牛排、玛格丽特披萨、意面... |
| 日料/韩餐 | 8 | 寿司拼盘、部队火锅、石锅拌饭... |
| 其他（鲁/湘/浙/淮扬/闽/徽/东北等） | 18 | 糖醋鲤鱼、剁椒鱼头、东坡肉... |
| 饮品/甜品 | 5 | 杨枝甘露、奶茶、提拉米苏... |
| 外卖 | 2 | 炸鸡、韩式炸鸡 |

### 1.3 数据格式示例

```json
{
  "version": "2.0",
  "update_time": "2026-06-15",
  "description": "今天吃啥 - 大学生日常菜品 v2.0（100道菜品）",
  "foods": [
    {
      "id": "001",
      "name": "宫保鸡丁",
      "spicy": "中等",
      "cuisine": "川菜",
      "main_ingredients": ["鸡胸肉", "花生", "干辣椒", "葱白"]
    }
  ]
}
```

### 1.4 v1.0 → v2.0 变更

| 变更项 | v1.0 | v2.0 |
|--------|------|------|
| 菜品数量 | ~50 道 | **100 道** |
| 外层结构 | 直接数组 | **包装对象**（version/foods 嵌套） |
| id 字段 | 无 | **新增**，三位数字编号 |
| spicy 类型 | boolean（true/false） | **字符串枚举**（不辣/微辣/中等/辣/特辣） |
| description 字段 | 有 | 移除，替换为 **main_ingredients 数组** |
| 菜系丰富度 | 4-5 种 | **18 种**（含食堂/外卖/饮品等贴近学生的分类） |

---

## 二、网络请求服务层（api_service.dart）

### 2.1 设计思路

`ApiService` 采用单例模式，为整个应用提供统一的 HTTP GET 能力。所有网络相关的异常（超时、断网、非200状态码、JSON 格式错误）都在此层统一捕获并转化为语义明确的错误信息。

### 2.2 核心功能

```dart
class ApiService {
  ApiService._internal();
  static final ApiService instance = ApiService._internal();

  /// 通用 GET 请求，自动处理：
  ///   • 10 秒超时（TimeoutException）
  ///   • HTTP 状态码检查（非 200 → error）
  ///   • JSON 解析验证（非 Map → error）
  ///   • 网络异常（ClientException）
  Future<LoadResult<Map<String, dynamic>>> getJson(String url) async {
    // ...
  }
}
```

### 2.3 LoadResult 统一结果包装

引入泛型结果包装类 `LoadResult<T>`，将加载过程抽象为五种状态：

```dart
enum LoadStatus { idle, loading, success, error, empty }

class LoadResult<T> {
  final LoadStatus status;    // 当前状态
  final T? data;              // 成功时的数据
  final String? message;      // 错误/空数据时的提示信息

  bool get isIdle => status == LoadStatus.idle;
  bool get isLoading => status == LoadStatus.loading;
  bool get isSuccess => status == LoadStatus.success;
  bool get isError => status == LoadStatus.error;
  bool get isEmpty => status == LoadStatus.empty;
}
```

UI 层只需判断 `isSuccess/isError/isEmpty` 即可完成三态渲染，无需关心底层异常类型。

---

## 三、数据仓库层（food_repository.dart）

### 3.1 设计思路

`FoodRepository` 在 ApiService 之上封装业务逻辑，负责：
- 调用 API 获取原始 JSON
- 提取 `foods` 数组并映射为 `Food` 数据模型
- 内存缓存避免重复请求
- 提供 UI 层友好的辅助方法

### 3.2 Food 数据模型

```dart
class Food {
  final String id;                    // 编号，如 "001"
  final String name;                  // 菜名，如 "宫保鸡丁"
  final String spicy;                 // 辣度，如 "中等"
  final String cuisine;               // 菜系，如 "川菜"
  final List<String> mainIngredients; // 主要食材

  factory Food.fromJson(Map<String, dynamic> json) { ... }

  /// 将食材数组转为中文逗号分隔文本
  String get ingredientsText => mainIngredients.join('、');
}
```

### 3.3 缓存策略

```dart
class FoodRepository {
  static final FoodRepository instance = FoodRepository._internal();
  List<Food>? _cache;  // 内存缓存

  Future<LoadResult<List<Food>>> fetchAllFoods({bool forceRefresh = false}) async {
    // 命中缓存 → 直接返回（除非 forceRefresh=true）
    if (!forceRefresh && _cache != null) return LoadResult.success(_cache!);

    // 调用 ApiService 拉取
    final result = await ApiService.instance.getJson(_dataUrl);

    // 解析 root['foods'] 数组 → List<Food>
    // ...

    _cache = foods;  // 写入缓存
    return LoadResult.success(foods);
  }

  /// 强制刷新（下拉刷新时调用）
  Future<LoadResult<List<Food>>> refresh() => fetchAllFoods(forceRefresh: true);
}
```

---

## 四、文件清单

| 文件 | 说明 |
|------|------|
| `food_list.json` | 菜品数据集（v2.0，100 道） |
| `lib/services/api_service.dart` | 网络请求服务层（单例 + LoadResult 四态 + 异常处理） |
| `lib/services/food_repository.dart` | 数据仓库层（Food 模型 + JSON 解析 + 内存缓存） |

---

## 五、测试记录

- [x] `flutter analyze` 通过无 warning
- [x] `flutter build web --release` 构建成功
- [x] 远程加载 food_list.json 成功（GitHub Raw URL 可访问）
- [x] 100 道菜品全部正确解析为 Food 对象
- [x] 五级辣度字段正确映射
- [x] main_ingredients 数组正确显示（以"、"分隔）
- [x] 网络断开时本地回退机制可用
- [x] 缓存生效后重复调用不产生新请求
