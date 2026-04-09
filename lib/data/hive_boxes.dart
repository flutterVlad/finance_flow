abstract class HiveBoxes {
  static String expenses(String? userId) => 'Expense${userId ?? ''}';

  static String cards(String? userId) => 'BankCard${userId ?? ''}';

  static String accounts() => 'Account';
}
