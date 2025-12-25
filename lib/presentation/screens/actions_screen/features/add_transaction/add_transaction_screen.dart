import 'package:finance_flow/presentation/screens/home_screen/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '/data/models/category/category.dart';
import '/utils/svgs/svg.dart';
import '/utils/theme.dart';
import '/utils/widgets/app_bottom_sheet.dart';
import '/utils/widgets/text_field_section.dart';
import 'bloc/transactions_cubit.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

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

  Category selectedCategory = defaultCategories[3];

  @override
  void initState() {
    super.initState();
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
    bloc.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add transaction',
          style: TextStyle(fontWeight: .bold),
        ),
      ),
      body: BlocBuilder<TransactionsCubit, TransactionsState>(
        builder: (context, state) => SingleChildScrollView(
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
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onSubmit: bloc.setAmount,
                  ),
                  Section(
                    controller: _categoryController,
                    onTap: () async {
                      await _chooseCategory(context);
                    },
                    title: 'Category',
                    hintText: selectedCategory.name,
                    suffixIcon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.grey,
                    ),
                    prefixIcon: Svg(
                      selectedCategory.iconAsset,
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
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<TransactionsCubit, TransactionsState>(
            builder: (context, state) {
              return Material(
                type: .button,
                color: state.isFormValid ? AppColors.primary : AppColors.grey,
                borderRadius: .circular(16),
                elevation: 3,
                child: InkWell(
                  borderRadius: .circular(16),
                  onTap: state.isFormValid
                      ? () {
                          homeBloc.add(AddExpenseEvent(state.validExpense));
                          Fluttertoast.showToast(
                            gravity: .SNACKBAR,
                            msg:
                                'Expense "${state.validExpense.name}" created successfully',
                            backgroundColor: Colors.green,
                            textColor: AppColors.onPrimary,
                          );
                          if (context.canPop()) context.pop();
                        }
                      : null,
                  child: const SizedBox(
                    height: 50,
                    child: Center(
                      child: Text(
                        'Create transaction',
                        style: TextStyle(
                          color: AppColors.onPrimary,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _chooseCategory(BuildContext context) async {
    await AppBottomSheet.show(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      item: AppBottomSheet.chooseCategoryItem(defaultCategories, (category) {
        bloc.setCategory(category);
        selectedCategory = category;
        _categoryController.text = category.name;
        if (context.canPop()) context.pop();
      }),
    );
  }
}
