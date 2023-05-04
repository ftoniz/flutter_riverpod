import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ft_flutter_riverpod/entity/category_entity.dart';
import 'package:ft_flutter_riverpod/repository/provider/category_list_provider.dart';
import 'package:ft_flutter_riverpod/repository/response/category_list_response.dart';

final categoryInfoViewModelProvider = StateNotifierProvider.autoDispose<
    CategoryInfoViewModelNotifier, CategoryInfoViewModelState>((ref) {
  var listResponse = ref.watch(requestCategoryListProvider);
  var title = ref.watch(_selectedCategoryTitleProvider);
  var state = CategoryInfoViewModelState(
    listResponse: listResponse,
    title: title,
    onChangeCategory: (title) {
      ref.read(_selectedCategoryTitleProvider.notifier).state = title;
    },
  );
  return CategoryInfoViewModelNotifier(state);
});

class CategoryInfoViewModelNotifier
    extends StateNotifier<CategoryInfoViewModelState> {
  CategoryInfoViewModelNotifier(super.state);
}

class CategoryInfoViewModelState {
  CategoryInfoViewModelState({
    required AsyncValue<CategoryListResponse> listResponse,
    required String title,
    required this.onChangeCategory,
  }) : super() {
    _title = title;
    listResponse.whenData((value) {
      _list = value.data ?? [];
    });
  }

  final void Function(String) onChangeCategory;

  List<CategoryEntity> _list = [];

  String _title = '';

  CategoryEntity? get category {
    var list = _list.where((element) => element.title == _title);
    if (list.isNotEmpty) {
      return list.first;
    }
    return null;
  }

  void previousCategory() {
    var currentIndex = _list.indexWhere((element) => element.title == _title);
    if (currentIndex < 0) return;

    var isFirstItem = currentIndex == 0;
    if (!isFirstItem) {
      setSelectCategory(title: _list[currentIndex - 1].title ?? '');
    } else {
      setSelectCategory(title: _list.last.title ?? '');
    }
  }

  void nextCategory() {
    var currentIndex = _list.indexWhere((element) => element.title == _title);
    var isLastItem = _list.length == currentIndex + 1;
    if (currentIndex < 0) return;
    if (!isLastItem) {
      var nextIndex = 1;
      while ((_list[currentIndex + nextIndex].title ?? '') == _title) {
        nextIndex++;
      }
      setSelectCategory(title: _list[currentIndex + nextIndex].title ?? '');
    } else {
      setSelectCategory(title: _list.first.title ?? '');
    }
  }

  void setSelectCategory({required String title}) {
    onChangeCategory(title);
  }
}

final _selectedCategoryTitleProvider = StateProvider<String>(
  (ref) => '',
);
