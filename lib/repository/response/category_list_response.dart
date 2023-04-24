import 'package:dio/dio.dart';
import 'package:ft_flutter_riverpod/entity/category_entity.dart';

class CategoryListResponse {
  List<CategoryEntity>? data;
  DioError? error;

  CategoryListResponse({
    this.data,
    this.error,
  });
}
