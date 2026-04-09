import '/data/models/response/response.dart';
import '/domain/repositories/card_repository.dart';
import '/domain/repositories/expense_repository.dart';
import '/domain/repositories/settings_repository.dart';

class DeleteAccountUseCase {
  final CardRepository cardRepository;
  final ExpenseRepository expenseRepository;
  final SettingsRepository settingsRepository;

  const DeleteAccountUseCase({
    required this.cardRepository,
    required this.expenseRepository,
    required this.settingsRepository,
  });

  Future<Response> execute(String userId) async {
    await expenseRepository.deleteAllExpenses(userId);
    await cardRepository.deleteAllCard(userId);
    return await settingsRepository.deleteAccount(userId);
  }
}
