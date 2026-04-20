import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/data/models/category/category.dart';
import '/l10n/app_localizations.dart';
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
    String? header,
  }) async {
    await show(
      context: context,
      useRootNavigator: true,
      scaleFactor: 0.4,
      item: Column(
        mainAxisSize: .min,
        children: [
          Text(
            header ?? S.of(context).chooseDate,
            style: const TextStyle(fontSize: 16, fontWeight: .bold),
          ),
          Expanded(
            child: CupertinoDatePicker(
              mode: mode ?? .dateAndTime,
              onDateTimeChanged: onDateTimeChanged,
              initialDateTime: initialDateTime,
              dateOrder: .dmy,
              use24hFormat: true,
            ),
          ),
        ],
      ),
    );
  }

  static Widget chooseCategoryItem({
    required BuildContext context,
    List<Category> categories = const [],
    List<Category> incomeCategory = const [],
    void Function(Category category)? onTap,
  }) {
    return DefaultTabController(
      length: 2,
      child: Column(
        spacing: 8,
        children: [
          Padding(
            padding: const .symmetric(horizontal: 16),
            child: Row(
              spacing: 16,
              children: [
                const Icon(Icons.list, color: AppColors.grey),
                Text(
                  S.of(context).categories,
                  style: const TextStyle(fontWeight: .bold, fontSize: 16),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 200,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: .circular(30),
              ),
              child: TabBar(
                indicatorPadding: const .all(4),
                tabAlignment: .fill,
                tabs: [
                  Tab(text: S.of(context).expenses, height: 40),
                  Tab(text: S.of(context).incomes, height: 40),
                ],
              ),
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
                      padding: const .fromLTRB(16, 16, 16, 32),
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
  const _KeyboardAwareBottomSheet({required this.item, this.padding});
  final Widget item;
  final EdgeInsets? padding;

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
