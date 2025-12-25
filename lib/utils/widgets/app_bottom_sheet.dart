import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    double scaleFactor = 0.7,
  }) async {
    return await showModalBottomSheet(
      isScrollControlled: isScrollControlled,
      useSafeArea: useSafeArea,
      shape: const RoundedRectangleBorder(
        borderRadius: .vertical(top: .circular(48)),
      ),
      backgroundColor: AppColors.secondary,
      constraints:
          constrains ??
          BoxConstraints(
            minWidth: MediaQuery.widthOf(context),
            maxHeight: scaleFactor * MediaQuery.heightOf(context),
          ),
      useRootNavigator: useRootNavigator,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsetsGeometry.only(
            top: 32,
            right: 32,
            left: 32,
            bottom: MediaQuery.viewInsetsOf(context).bottom + 32,
          ),
          child: item,
        );
      },
    );
  }

  static Future<void> showDatePicker(
    BuildContext context,
    void Function(DateTime date) onDateTimeChanged, {
    CupertinoDatePickerMode? mode,
    DateTime? initialDateTime,
  }) async {
    await show(
      context: context,
      useRootNavigator: true,
      isScrollControlled: false,
      scaleFactor: 0.4,
      item: Column(
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

  static Widget chooseCategoryItem(
    List<Category> categories,
    void Function(Category category) onTap,
  ) {
    return Column(
      spacing: 16,
      children: [
        const Row(
          spacing: 16,
          children: [
            Icon(Icons.list, color: AppColors.grey),
            Text(
              'Categories',
              style: TextStyle(fontWeight: .bold, fontSize: 16),
            ),
          ],
        ),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];

              return InkWell(
                onTap: () {
                  onTap.call(category);
                },
                borderRadius: .circular(20),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: .circular(20),
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
        ),
      ],
    );
  }
}
