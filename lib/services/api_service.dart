// lib/services/api_service.dart
// 组员C：网络请求层 + 加载状态封装
// 职责：封装 http.get 请求，把加载/成功/失败/空数据四种状态统一返回

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

/// 数据加载状态
enum LoadStatus { idle, loading, success, error, empty }

/// 统一的加载结果包装：UI 层只需判断 status
class LoadResult<T> {
  final LoadStatus status;
  final T? data;
  final String? message;

  const LoadResult._({
    required this.status,
    this.data,
    this.message,
  });

  factory LoadResult.idle() =>
      const LoadResult._(status: LoadStatus.idle);

  factory LoadResult.loading() =>
      const LoadResult._(status: LoadStatus.loading);

  factory LoadResult.success(T data) =>
      LoadResult._(status: LoadStatus.success, data: data);

  factory LoadResult.error(String msg) =>
      LoadResult._(status: LoadStatus.error, message: msg);

  factory LoadResult.empty([String msg = '菜品数据为空']) =>
      LoadResult._(status: LoadStatus.empty, message: msg);

  bool get isIdle => status == LoadStatus.idle;
  bool get isLoading => status == LoadStatus.loading;
  bool get isSuccess => status == LoadStatus.success;
  bool get isError => status == LoadStatus.error;
  bool get isEmpty => status == LoadStatus.empty;
}

/// 网络请求服务（单例）
class ApiService {
  ApiService._internal();
  static final ApiService instance = ApiService._internal();

  /// 通用 GET 请求，自动处理超时、HTTP 状态码、JSON 解析
  /// 返回 LoadResult<Map>，UI 层根据 status 判断
  Future<LoadResult<Map<String, dynamic>>> getJson(String url) async {
    try {
      final response = await http
          .get(
            Uri.parse(url),
            headers: const {'Accept': 'application/json'},
          )
          .timeout(const Duration(seconds: 10));

      // 1) HTTP 状态码检查
      if (response.statusCode != 200) {
        return LoadResult.error('网络请求失败（状态码 ${response.statusCode}）');
      }

      // 2) JSON 解析
      final dynamic decoded = json.decode(response.body);
      if (decoded is! Map<String, dynamic>) {
        return LoadResult.error('返回数据格式错误（不是 JSON 对象）');
      }

      return LoadResult.success(decoded);
    } on TimeoutException {
      return LoadResult.error('请求超时，请检查网络');
    } on http.ClientException catch (e) {
      return LoadResult.error('网络异常：${e.message}');
    } on FormatException {
      return LoadResult.error('数据格式错误，联系开发者');
    } catch (e) {
      return LoadResult.error('未知错误：$e');
    }
  }
}
