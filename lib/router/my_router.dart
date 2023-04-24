import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ft_flutter_riverpod/entity/category_entity.dart';
import 'package:ft_flutter_riverpod/page/category_info/category_info_view.dart';
import 'package:ft_flutter_riverpod/page/category_info/category_info_viewmodel.dart';
import 'package:ft_flutter_riverpod/page/category_list/category_list_view.dart';
import 'package:go_router/go_router.dart';

extension MyRouterHelper on BuildContext {
  MyRouter get router => MyRouter(context: this);
}

class MyRouter {
  final BuildContext context;

  MyRouter({required this.context});

  void pushToCategoryInfo({
    required CategoryEntity category,
    required WidgetRef ref,
  }) {
    ref
        .read(categoryInfoViewModelProvider)
        .setSelectCategory(title: category.title ?? '');

    context.push(CategoryInfoView.routePath);
  }

  void pushToCategoryList() {
    context.push(CategoryListView.routePath);
  }
}
