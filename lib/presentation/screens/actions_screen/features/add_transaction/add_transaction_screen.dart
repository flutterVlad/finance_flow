import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '/data/models/category/category.dart';
import '/presentation/screens/home_screen/bloc/home_bloc.dart';
import '/utils/svgs/svg.dart';
import '/utils/theme.dart';
import '/utils/widgets/app_bottom_sheet.dart';
import '/utils/widgets/primary_button.dart';
import '/utils/widgets/text_field_section.dart';
import 'bloc/transactions_cubit.dart';

class AddTransactionScreen extends StatefulWidget {
  final bool isAddIncome;

  const AddTransactionScreen({super.key, this.isAddIncome = false});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final bloc = GetIt.I<TransactionsCubit>();
  final homeBloc = GetIt.I<HomeBloc>();

  late final TextEditingController _nameController;
  late final TextEditingController _amountController;
  late final TextEditingController _categoryController;
  late final TextEditingController _dateController;

  @override
  void initState() {
    super.initState();
    if (widget.isAddIncome) bloc.initIncomeTransaction();
    _nameController = TextEditingController();
    _amountController = TextEditingController();
    _categoryController = TextEditingController();
    bloc.setDate(DateTime.now());
    _dateController = TextEditingController(
      text: DateFormat('d MMMM y').format(DateTime.now()),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    _categoryController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          title: const Text(
            'Add transaction',
            style: TextStyle(fontWeight: .bold),
          ),
        ),
        body: BlocBuilder<TransactionsCubit, TransactionsState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const .all(16),
                child: Form(
                  child: Column(
                    crossAxisAlignment: .start,
                    spacing: 16,
                    children: [
                      Section(
                        controller: _nameController,
                        title: 'Transaction name',
                        hintText: 'Trip to Turkey',
                        keyboardType: .text,
                        onSubmit: bloc.setName,
                      ),
                      Section(
                        controller: _amountController,
                        title: 'Amount',
                        hintText: '120',
                        suffix: const Text(' Br'),
                        keyboardType: const .numberWithOptions(decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        onSubmit: bloc.setAmount,
                      ),
                      Section(
                        controller: _categoryController,
                        onTap: () async {
                          await _chooseCategory(context);
                        },
                        title: 'Category',
                        hintText: state.categoryInput.value.name,
                        suffixIcon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: AppColors.grey,
                        ),
                        prefixIcon: Svg(
                          state.categoryInput.value.iconAsset,
                          color: AppColors.primary,
                          size: 30,
                        ),
                      ),
                      Section(
                        title: 'Date and time',
                        controller: _dateController,
                        suffixIcon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: AppColors.grey,
                        ),
                        onTap: () {
                          AppBottomSheet.showDatePicker(context, (date) {
                            _dateController.text = DateFormat(
                              'd MMMM y',
                            ).format(date);
                            bloc.setDate(date);
                          });
                        },
                      ),
                      Section(
                        title: 'Income',
                        enabled: !state.isIncomeCategorySelected,
                        boolValue: state.isIncome,
                        isBool: true,
                        onBoolChange: (newBool) {
                          bloc.setIncome(newBool);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: BlocBuilder<TransactionsCubit, TransactionsState>(
              builder: (context, state) {
                return PrimaryButton(
                  text: 'Create transaction',
                  enabled: state.isFormValid,
                  onTap: () {
                    homeBloc.add(AddExpenseEvent(state.validExpense));
                    Fluttertoast.showToast(
                      gravity: .TOP,
                      msg:
                          'Expense "${state.validExpense.name}" created successfully',
                      backgroundColor: Colors.green,
                      textColor: AppColors.onPrimary,
                    );
                    if (context.canPop()) context.pop();
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _chooseCategory(BuildContext context) async {
    await AppBottomSheet.show(
      context: context,
      isScrollControlled: true,
      scaleFactor: 0.75,
      item: AppBottomSheet.chooseCategoryItem(
        categories: defaultCategories.sublist(
          0,
          defaultCategories.indexWhere((e) => e.isIncome),
        ),
        incomeCategory: defaultCategories.sublist(
          defaultCategories.indexWhere((e) => e.isIncome),
        ),
        onTap: (category) {
          bloc.setCategory(category);
          _categoryController.text = category.name;
        },
      ),
    );
  }
}
