import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ft_flutter_riverpod/repository/public_api.dart';
import 'package:ft_flutter_riverpod/repository/response/category_list_response.dart';

final requestCategoryListProvider =
    AsyncNotifierProvider<RequestCategoryListNotifier, CategoryListResponse>(
  () => RequestCategoryListNotifier(),
);

class RequestCategoryListNotifier extends AsyncNotifier<CategoryListResponse> {
  @override
  Future<CategoryListResponse> build() => _fetch();

  Future<CategoryListResponse> _fetch() async =>
      PublicApi().requestAllCategory();
}
