import '/data/hive_boxes.dart';
import '/data/mappers/account_mapper.dart';
import '/data/models/bank_card/bank_card.dart';
import '/data/models/response/response.dart';
import '/data/service/encryption_key_service.dart';
import '/data/service/hive_service.dart';
import '/domain/repositories/card_repository.dart';
import '/presentation/screens/wallet_screen/entities/card_form.dart';

class CardRepositoryImpl implements CardRepository {
  final HiveService _hiveService;
  final EncryptionKeyService _encryptionKeyService;

  const CardRepositoryImpl({
    required HiveService hiveService,
    required EncryptionKeyService encryptionKeyService,
  }) : _hiveService = hiveService,
       _encryptionKeyService = encryptionKeyService;

  @override
  Future<Response> saveCard(CardForm form, String userId) async {
    final bankCard = form.toModel();
    final cards = await getCards(userId);

    if (cards.any((e) => e.id == bankCard.id)) {
      return const Response(
        message: "You already have the same card",
        success: false,
      );
    }
    final response = await _hiveService.putData<BankCard>(
      bankCard.id,
      bankCard,
      encryptKey: await _encryptionKeyService.getOrCreateKey(),
      boxKey: HiveBoxes.cards(userId),
    );

    return response.changeSuccessMessage("Card saved successfully");
  }

  @override
  Future<List<BankCard>> getCards(String userId) async {
    return await _hiveService.getAllData<BankCard>(
      encryptKey: await _encryptionKeyService.getOrCreateKey(),
      boxKey: HiveBoxes.cards(userId),
    );
  }

  @override
  Future<Response> deleteCard(String id, String userId) async {
    final response = await _hiveService.deleteData<BankCard>(
      id,
      encryptKey: await _encryptionKeyService.getOrCreateKey(),
      boxKey: HiveBoxes.cards(userId),
    );

    return response.changeSuccessMessage("Card deleted");
  }

  @override
  Future<Response> deleteAllCard(String userId) async {
    final response = await _hiveService.deleteAllData<BankCard>(
      encryptKey: await _encryptionKeyService.getOrCreateKey(),
      boxKey: HiveBoxes.cards(userId),
    );

    return response.changeSuccessMessage("All cards deleted");
  }
}
