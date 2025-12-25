import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import '/presentation/screens/home_screen/bloc/home_bloc.dart';
import '/utils/theme.dart';
import '/utils/widgets/app_bottom_sheet.dart';

class DateFilter extends StatelessWidget {
  const DateFilter({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = GetIt.I<HomeBloc>();

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return SliverToBoxAdapter(
          child: Padding(
            padding: const .all(16),
            child: Material(
              borderRadius: .circular(16),
              child: InkWell(
                onTap: () {
                  AppBottomSheet.showDatePicker(
                    context,
                    (date) {
                      bloc.add(FilterMonthEvent(date));
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
                            DateFormat('MMMM y').format(state.monthFilter),
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
