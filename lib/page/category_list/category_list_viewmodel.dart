import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ft_flutter_riverpod/entity/category_entity.dart';
import 'package:ft_flutter_riverpod/repository/provider/category_list_provider.dart';
import 'package:ft_flutter_riverpod/repository/response/category_list_response.dart';

final categoryListViewProvider = ChangeNotifierProvider.autoDispose(
  (ref) {
    var listResponse = ref.watch(categoryListNotifierProvider);
    var listNotifier = ref.watch(categoryListNotifierProvider.notifier);
    return CategoryListViewModel(
      listResponse: listResponse,
      listNotifier: listNotifier,
    );
  },
);

class CategoryListViewModel extends ChangeNotifier {
  CategoryListViewModel({
    required CategoryListResponse? listResponse,
    required CategoryListNotifier listNotifier,
  }) : super() {
    _listResponse = listResponse;
    _listNotifier = listNotifier;
  }

  late CategoryListResponse? _listResponse;
  late CategoryListNotifier _listNotifier;

  bool _isLoading = false;

  List<CategoryEntity> get list => _listResponse?.data ?? [];

  bool get isLoading => _isLoading;

  Future fetchCategoryList() async {
    _isLoading = true;
    notifyListeners();

    await _listNotifier.fetch();
    _isLoading = false;
    notifyListeners();
  }
}
