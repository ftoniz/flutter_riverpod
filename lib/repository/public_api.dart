import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ft_flutter_riverpod/entity/category_entity.dart';
import 'package:ft_flutter_riverpod/repository/base/app_network.dart';
import 'package:ft_flutter_riverpod/repository/response/category_list_response.dart';

final publicApiProvider = Provider((ref) => PublicApi());

class PublicApi {
  final _network = AppNetwork();

  Future<CategoryListResponse> requestAllCategory() async {
    try {
      var response = await _network.get<Map<String, dynamic>>('/entries');

      var list = (response.data!['entries'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList();

      return CategoryListResponse(
        data: list.map((e) => CategoryEntity.fromJson(e)).toList(),
      );
    } on DioError catch (e) {
      return CategoryListResponse(error: e);
    }
  }
}
