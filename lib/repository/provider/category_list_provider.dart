import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ft_flutter_riverpod/entity/category_entity.dart';
import 'package:ft_flutter_riverpod/repository/public_api.dart';
import 'package:ft_flutter_riverpod/repository/response/category_list_response.dart';

List<CategoryEntity> _savedCategoryList = [];

final categoryListNotifierProvider = StateNotifierProvider.autoDispose<
    CategoryListNotifier, CategoryListResponse?>(
  (ref) {
    var savedList = ref.read(_savedCategoryListProvider);
    var publicApi = ref.read(publicApiProvider);
    if (savedList.isNotEmpty) {
      return CategoryListNotifier(
        CategoryListResponse(data: savedList),
        publicApi: publicApi,
      );
    }

    return CategoryListNotifier(
      CategoryListResponse(),
      publicApi: publicApi,
    );
  },
);

final _savedCategoryListProvider =
    Provider<List<CategoryEntity>>((ref) => _savedCategoryList);

class CategoryListNotifier extends StateNotifier<CategoryListResponse> {
  CategoryListNotifier(
    super.state, {
    required this.publicApi,
  }) {
    if (state.data == null) {
      fetch();
    }
  }

  final PublicApi publicApi;

  Future fetch() async {
    var response = await publicApi.requestAllCategory();
    if (response.error == null) {
      state = response;
      _savedCategoryList = response.data ?? [];
    }
  }
}
