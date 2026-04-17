// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class SEn extends S {
  SEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Finance Flow';

  @override
  String get cardSaved => 'Card saved successfully';

  @override
  String get cardDeleted => 'Card deleted';

  @override
  String get cardAlreadyExists => 'You already have the same card';

  @override
  String get deleteAccount => 'Delete account';

  @override
  String confirmDelete(String name) {
    return 'Are you sure you want to delete $name?';
  }

  @override
  String get myProfile => 'My Profile';

  @override
  String get editAccount => 'Edit account';

  @override
  String get createAccount => 'Create account';

  @override
  String get language => 'Language';

  @override
  String get paymentMethod => 'Payment method';

  @override
  String get accountSecurity => 'Account Security';

  @override
  String get notifications => 'Notifications';

  @override
  String get clearCache => 'Clear Cache';

  @override
  String get settings => 'Settings';

  @override
  String get helpCentre => 'Help Centre';

  @override
  String get privacyPolicy => 'Privacy & Policy';

  @override
  String get aboutApp => 'About App';

  @override
  String get makeThisAccountPrimary => 'Make this account primary';

  @override
  String get create => 'Create';

  @override
  String get save => 'Save';

  @override
  String get firstName => 'First Name';

  @override
  String get lastName => 'Last Name';

  @override
  String get monthlyExpenses => 'Monthly expenses';

  @override
  String get recentExpenses => 'Recent Expenses';

  @override
  String get spendThisMonth => 'Spend this month';

  @override
  String get nothingToShow => 'Nothing to show(';

  @override
  String get chooseDate => 'Choose date';

  @override
  String get categories => 'Categories';

  @override
  String get expenses => 'Expenses';

  @override
  String get incomes => 'Incomes';

  @override
  String get today => 'Today';

  @override
  String get yesterday => 'Yesterday';

  @override
  String get noDataInThisMonth => 'No data in this month';

  @override
  String get byn => 'Br';

  @override
  String get welcomeBack => 'Welcome back 👋';

  @override
  String get expenseAnalytics => 'Expense Analytics';

  @override
  String get todayExpenses => 'Today\'s Expenses';

  @override
  String get viewAll => 'View All';

  @override
  String get walletBalance => 'Wallet Balance';

  @override
  String get wallet => 'Wallet';

  @override
  String get spent => 'Spent';

  @override
  String get budget => 'Budget';

  @override
  String get income => 'Income';

  @override
  String get allSpends => 'All Spends';

  @override
  String addItem(String name) {
    return 'Add $name';
  }

  @override
  String get actions => 'Actions';

  @override
  String get addTransaction => 'Add transaction';

  @override
  String get noCardsAddedYet => 'No cards added yet';

  @override
  String get addCard => 'Add card';

  @override
  String get needToCreateAccount => 'Need to create account';

  @override
  String get cancel => 'Cancel';

  @override
  String get exit => 'Exit';

  @override
  String get confirm => 'Confirm';

  @override
  String get fieldCanNotBeEmpty => 'Field can not be empty';

  @override
  String get invalidLength => 'Invalid length';

  @override
  String get invalidFormat => 'Invalid format';

  @override
  String get invalidCardNumber => 'Invalid card number';

  @override
  String get weeklyExpense => 'Weekly Expense';

  @override
  String fromDate(Object date) {
    return 'From $date';
  }
}
