import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ft_flutter_riverpod/entity/category_entity.dart';
import 'package:ft_flutter_riverpod/repository/provider/category_list_provider.dart';
import 'package:ft_flutter_riverpod/repository/response/category_list_response.dart';

final categoryListViewModelProvider = StateNotifierProvider.autoDispose<
    CategoryListViewModelNotifier, CategoryListViewModelState>((ref) {
  var listResponse = ref.watch(requestCategoryListProvider);

  var state = CategoryListViewModelState(
    listResponse: listResponse,
  );
  return CategoryListViewModelNotifier(state);
});

class CategoryListViewModelNotifier
    extends StateNotifier<CategoryListViewModelState> {
  CategoryListViewModelNotifier(super.state);
}

class CategoryListViewModelState {
  CategoryListViewModelState({
    required AsyncValue<CategoryListResponse> listResponse,
  }) : super() {
    _isLoading = listResponse.isLoading;

    listResponse.when(
      data: (value) {
        _list = value.data ?? [];
      },
      error: (error, stackTrace) {},
      loading: () {
        _isLoading = listResponse.isLoading;
      },
    );
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<CategoryEntity> _list = [];
  List<CategoryEntity> get list => _list;
}
