import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ft_flutter_riverpod/constant/colors.dart';
import 'package:ft_flutter_riverpod/page/category_info/category_info_viewmodel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CategoryInfoView extends HookWidget {
  static const String routePath = '/info';

  const CategoryInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => HookConsumer(
        builder: (context, ref, child) {
          var viewModel = ref.watch(categoryInfoViewModelProvider);

          return Scaffold(
            appBar: AppBar(
              primary: true,
              title: Text(viewModel.category?.title ?? '-'),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 16,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        Text(viewModel.category?.title ?? '-'),
                        const SizedBox(height: 8),
                        Text(viewModel.category?.description ?? '-'),
                        const SizedBox(height: 8),
                        Text(viewModel.category?.auth ?? '-'),
                        const SizedBox(height: 8),
                        Text(viewModel.category?.link ?? '-'),
                      ],
                    ),
                  ),
                  Container(
                    height: 2,
                    color: AppColors.appAccent,
                  ),
                  SizedBox(
                    height: 80,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              ref
                                  .read(categoryInfoViewModelProvider)
                                  .previousCategory();
                            },
                            child: const Text('<<<< Previous'),
                          ),
                        ),
                        Container(
                          width: 2,
                          color: AppColors.appAccent,
                        ),
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              ref
                                  .read(categoryInfoViewModelProvider)
                                  .nextCategory();
                            },
                            child: const Text('Next >>>>'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
}
