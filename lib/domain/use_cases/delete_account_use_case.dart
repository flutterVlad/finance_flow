import '/data/models/response/response.dart';
import '/domain/repositories/card_repository.dart';
import '/domain/repositories/expense_repository.dart';
import '/domain/repositories/settings_repository.dart';

class DeleteAccountUseCase {
  const DeleteAccountUseCase({
    required this.cardRepository,
    required this.expenseRepository,
    required this.settingsRepository,
  });
  final CardRepository cardRepository;
  final ExpenseRepository expenseRepository;
  final SettingsRepository settingsRepository;

  Future<Response> execute(String userId) async {
    await expenseRepository.deleteAllExpenses(userId);
    await cardRepository.deleteAllCard(userId);
    return await settingsRepository.deleteAccount(userId);
  }
}
