// lib/services/food_repository.dart
// 组员C：JSON 解析 + 数据封装
// 职责：调用 ApiService 拉数据，解析为 Food 对象，封装为 UI 层友好的接口

import 'api_service.dart';

/// 菜品数据模型
class Food {
  final String id;
  final String name;
  final String spicy;
  final String cuisine;
  final List<String> mainIngredients;

  const Food({
    required this.id,
    required this.name,
    required this.spicy,
    required this.cuisine,
    required this.mainIngredients,
  });

  /// 从 JSON 单条数据构造
  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '未知菜品',
      spicy: json['spicy']?.toString() ?? '未知',
      cuisine: json['cuisine']?.toString() ?? '未知',
      mainIngredients: (json['main_ingredients'] as List?)
              ?.map((e) => e.toString())
              .toList() ??
          <String>[],
    );
  }

  /// UI 层显示用的辅助方法
  String get ingredientsText => mainIngredients.join('、');

  @override
  String toString() =>
      'Food(id: $id, name: $name, spicy: $spicy, cuisine: $cuisine)';
}

/// 菜品仓库（单例）：负责把远端 JSON 解析为 List<Food>
class FoodRepository {
  FoodRepository._internal();
  static final FoodRepository instance = FoodRepository._internal();

  // ============================================================
  // ↓↓↓ 组长合并 PR 后，把下面这行替换为真实 raw 链接 ↓↓
  //   https://raw.githubusercontent.com/t-1tian/flutter_food_picker/main/food_list.json
  // ============================================================
  static const String _dataUrl =
      'https://raw.githubusercontent.com/t-1tian/flutter_food_picker/main/food_list.json';

  /// 内存缓存（避免重复请求）
  List<Food>? _cache;

  /// 拉取全部菜品
  /// 返回 LoadResult<List<Food>>，覆盖：loading/success/empty/error 四种状态
  Future<LoadResult<List<Food>>> fetchAllFoods({bool forceRefresh = false}) async {
    // 命中缓存
    if (!forceRefresh && _cache != null) {
      return LoadResult.success(_cache!);
    }

    // 1) 调 ApiService 拉 JSON
    final result = await ApiService.instance.getJson(_dataUrl);

    // 2) 透传错误 / loading 状态
    if (result.isError) return LoadResult.error(result.message!);
    if (!result.isSuccess) return LoadResult.error('未知加载状态');

    // 3) 解析 foods 数组
    final root = result.data!;
    final List<dynamic> foodsJson = (root['foods'] as List?) ?? <dynamic>[];

    if (foodsJson.isEmpty) {
      return LoadResult.empty('菜品数据为空，请联系开发者');
    }

    final List<Food> foods = foodsJson
        .where((e) => e is Map<String, dynamic>)
        .map((e) => Food.fromJson(e))
        .toList();

    if (foods.isEmpty) {
      return LoadResult.empty('菜品数据为空，请联系开发者');
    }

    // 4) 写入缓存
    _cache = foods;
    return LoadResult.success(foods);
  }

  /// 刷新缓存（用户下拉刷新时调用）
  Future<LoadResult<List<Food>>> refresh() => fetchAllFoods(forceRefresh: true);

  /// 清空缓存
  void clearCache() {
    _cache = null;
  }
}
