import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ft_flutter_riverpod/entity/category_entity.dart';
import 'package:ft_flutter_riverpod/repository/provider/category_list_provider.dart';
import 'package:ft_flutter_riverpod/repository/response/category_list_response.dart';

final categoryInfoViewModelProvider = ChangeNotifierProvider.autoDispose(
  (ref) {
    var listResponse = ref.watch(categoryListNotifierProvider);
    var categoryTitle = ref.watch(_selectedCategoryTitleNotifierProvider);
    var categoryTitleNotifier =
        ref.watch(_selectedCategoryTitleNotifierProvider.notifier);
    var viewModel = CategoryInfoViewModel(
      listResponse: listResponse,
      categoryTitle: categoryTitle,
      selectedTitleNotifier: categoryTitleNotifier,
    );

    return viewModel;
  },
);

class CategoryInfoViewModel extends ChangeNotifier {
  CategoryInfoViewModel({
    required CategoryListResponse? listResponse,
    required String categoryTitle,
    required SelectedCategoryTitleNotifier selectedTitleNotifier,
  }) : super() {
    _listResponse = listResponse;
    _categoryTitle = categoryTitle;
    _selectedTitleNotifier = selectedTitleNotifier;
  }

  late CategoryListResponse? _listResponse;
  late SelectedCategoryTitleNotifier _selectedTitleNotifier;

  String _categoryTitle = '';

  CategoryEntity? get category {
    var list = _listResponse?.data
            ?.where((element) => element.title == _categoryTitle) ??
        [];
    if (list.isNotEmpty) {
      return list.first;
    }
    return null;
  }

  void previousCategory() {
    var list = _listResponse?.data ?? [];
    var currentIndex =
        list.indexWhere((element) => element.title == _categoryTitle);
    if (currentIndex < 0) return;

    var isFirstItem = currentIndex == 0;
    if (!isFirstItem) {
      setSelectCategory(title: list[currentIndex - 1].title ?? '');
    } else {
      setSelectCategory(title: list.last.title ?? '');
    }
  }

  void nextCategory() {
    var list = _listResponse?.data ?? [];
    var currentIndex =
        list.indexWhere((element) => element.title == _categoryTitle);
    var isLastItem = list.length == currentIndex + 1;
    if (currentIndex < 0) return;
    if (!isLastItem) {
      var nextIndex = 1;
      while ((list[currentIndex + nextIndex].title ?? '') == _categoryTitle) {
        nextIndex++;
      }
      setSelectCategory(title: list[currentIndex + nextIndex].title ?? '');
    } else {
      setSelectCategory(title: list.first.title ?? '');
    }
  }

  void setSelectCategory({required String title}) {
    _selectedTitleNotifier.setSelected(title);
  }
}

final _selectedCategoryTitleNotifierProvider =
    StateNotifierProvider<SelectedCategoryTitleNotifier, String>(
  (ref) => SelectedCategoryTitleNotifier(''),
);

class SelectedCategoryTitleNotifier extends StateNotifier<String> {
  SelectedCategoryTitleNotifier(super.state);

  // ignore: use_setters_to_change_properties
  void setSelected(String title) {
    state = title;
  }
}
