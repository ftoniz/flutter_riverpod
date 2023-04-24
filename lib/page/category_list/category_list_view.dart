import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ft_flutter_riverpod/entity/category_entity.dart';
import 'package:ft_flutter_riverpod/page/category_list/category_list_viewmodel.dart';
import 'package:ft_flutter_riverpod/router/my_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CategoryListView extends HookWidget {
  static const String routePath = '/';

  const CategoryListView({Key? key}) : super(key: key);

  Widget _itemWidget({
    required BuildContext context,
    required CategoryEntity category,
    required WidgetRef ref,
  }) =>
      ListTile(
        onTap: () {
          context.router.pushToCategoryInfo(
            category: category,
            ref: ref,
          );
        },
        title: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            category.title ?? '',
            style: const TextStyle(color: Colors.black, fontSize: 20),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          primary: true,
          title: const Text('Categories'),
        ),
        body: HookConsumer(
          builder: (context, ref, _) {
            var list = ref.watch(categoryListViewProvider).list;
            return ListView.separated(
              itemBuilder: (context, index) {
                var category = list[index];
                return _itemWidget(
                  context: context,
                  category: category,
                  ref: ref,
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                height: 4,
              ),
              itemCount: list.length,
            );
          },
        ),
      );
}
