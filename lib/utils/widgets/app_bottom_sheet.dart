import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/data/models/category/category.dart';
import '../svgs/svg.dart';
import '../theme.dart';

abstract class AppBottomSheet {
  static Future<void> show({
    required BuildContext context,
    required Widget item,
    BoxConstraints? constrains,
    bool useRootNavigator = false,
    bool useSafeArea = false,
    bool isScrollControlled = false,
    double? scaleFactor,
    EdgeInsets? padding,
    bool isDismissible = true,
  }) async {
    return await showModalBottomSheet(
      isScrollControlled: isScrollControlled,
      useSafeArea: useSafeArea,
      isDismissible: isDismissible,
      shape: const RoundedRectangleBorder(
        borderRadius: .vertical(top: .circular(24)),
      ),
      backgroundColor: AppColors.secondary,
      constraints: scaleFactor != null
          ? BoxConstraints(
              maxHeight: MediaQuery.heightOf(context) * scaleFactor,
            )
          : null,
      useRootNavigator: useRootNavigator,
      context: context,
      builder: (context) {
        return _KeyboardAwareBottomSheet(item: item, padding: padding);
      },
    );
  }

  static Future<void> showDatePicker({
    required BuildContext context,
    required void Function(DateTime date) onDateTimeChanged,
    CupertinoDatePickerMode? mode,
    DateTime? initialDateTime,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    await show(
      context: context,
      useRootNavigator: true,
      isScrollControlled: false,
      scaleFactor: 0.4,
      item: Column(
        mainAxisSize: .min,
        children: [
          const Text(
            'Choose date',
            style: TextStyle(fontSize: 16, fontWeight: .bold),
          ),
          Expanded(
            child: CupertinoDatePicker(
              mode: mode ?? .dateAndTime,
              onDateTimeChanged: onDateTimeChanged,
              initialDateTime: initialDateTime,
            ),
          ),
        ],
      ),
    );
  }

  static Widget chooseCategoryItem({
    List<Category> categories = const [],
    List<Category> incomeCategory = const [],
    void Function(Category category)? onTap,
  }) {
    return DefaultTabController(
      length: 2,
      child: Column(
        spacing: 8,
        children: [
          const Padding(
            padding: .symmetric(horizontal: 16),
            child: Row(
              spacing: 16,
              children: [
                Icon(Icons.list, color: AppColors.grey),
                Text(
                  'Categories',
                  style: TextStyle(fontWeight: .bold, fontSize: 16),
                ),
              ],
            ),
          ),
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: .circular(30),
            ),
            child: const TabBar(
              indicatorPadding: .all(4),
              tabs: [
                Tab(text: 'Expenses', height: 40),
                Tab(text: 'Incomes', height: 40),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [categories, incomeCategory]
                  .map(
                    (e) => GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                          ),
                      itemCount: e.length,
                      padding: const .symmetric(horizontal: 16),
                      itemBuilder: (context, index) {
                        final category = e[index];

                        return InkWell(
                          onTap: () {
                            onTap?.call(category);
                            if (context.canPop()) context.pop();
                          },
                          borderRadius: .circular(20),
                          child: Column(
                            children: [
                              Container(
                                width: 56,
                                height: 56,
                                decoration: BoxDecoration(
                                  borderRadius: .circular(30),
                                  border: Border.all(color: AppColors.grey),
                                ),
                                padding: const .all(8),
                                child: Svg(category.iconAsset),
                              ),
                              Text(
                                category.name,
                                style: const TextStyle(fontSize: 12),
                                overflow: .ellipsis,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _KeyboardAwareBottomSheet extends StatelessWidget {
  final Widget item;
  final EdgeInsets? padding;

  const _KeyboardAwareBottomSheet({required this.item, this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          padding?.copyWith(
            bottom:
                MediaQuery.of(context).viewInsets.bottom +
                (padding?.bottom ?? 0),
          ) ??
          EdgeInsets.only(
            top: 32,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
      child: item,
    );
  }
}
