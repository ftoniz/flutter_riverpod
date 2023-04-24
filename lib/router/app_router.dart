import 'package:flutter/material.dart';
import 'package:ft_flutter_riverpod/page/category_info/category_info_view.dart';
import 'package:ft_flutter_riverpod/page/category_list/category_list_view.dart';
import 'package:go_router/go_router.dart';

mixin AppRouter on StatelessWidget {
  GoRouter buildRouter() => GoRouter(
        routes: <RouteBase>[
          GoRoute(
            path: CategoryListView.routePath,
            builder: (context, state) => const CategoryListView(),
          ),
          GoRoute(
            path: CategoryInfoView.routePath,
            builder: (context, state) => const CategoryInfoView(),
          ),
        ],
        initialLocation: CategoryListView.routePath,
      );
}
