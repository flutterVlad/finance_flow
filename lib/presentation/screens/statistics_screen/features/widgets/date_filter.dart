import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '/di.dart';
import '/l10n/app_localizations.dart';
import '/presentation/bloc/expense/expense_bloc.dart';
import '/utils/extensions.dart';
import '/utils/theme.dart';
import '/utils/widgets/app_bottom_sheet.dart';

class DateFilter extends StatelessWidget {
  const DateFilter({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = getIt<ExpenseBloc>();

    return BlocBuilder<ExpenseBloc, ExpenseState>(
      builder: (context, state) {
        return SliverToBoxAdapter(
          child: Padding(
            padding: const .all(16),
            child: Material(
              borderRadius: .circular(16),
              child: InkWell(
                onTap: () {
                  AppBottomSheet.showDatePicker(
                    context: context,
                    onDateTimeChanged: (date) {
                      bloc.add(.filterMonth(date));
                    },
                    mode: .monthYear,
                    initialDateTime: state.monthFilter,
                  );
                },
                borderRadius: .circular(16),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: .circular(16),
                    color: AppColors.onPrimary,
                  ),
                  padding: const .all(8),
                  child: Center(
                    child: Row(
                      mainAxisSize: .min,
                      children: [
                        SizedBox(
                          width: 115,
                          child: Text(
                            DateFormat(
                              'LLLL y',
                              S.of(context).localeName,
                            ).format(state.monthFilter).capitalize(),
                            textDirection: .rtl,
                          ),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down,
                          color: AppColors.grey,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
