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
  Future<Response> saveCard(CardForm form, String userUuid) async {
    final bankCard = form.toModel();

    return await _hiveService.putData<BankCard>(
      bankCard.number,
      bankCard,
      encryptKey: await _encryptionKeyService.getOrCreateKey(),
      boxKey: userUuid,
    );
  }

  @override
  Future<List<BankCard>> getCards(String userUuid) async =>
      await _hiveService.getAllData<BankCard>(
        encryptKey: await _encryptionKeyService.getOrCreateKey(),
        boxKey: userUuid,
      );

  @override
  Future<Response> deleteCard(String cardNumber, String userUuid) async {
    return await _hiveService.deleteData<BankCard>(
      cardNumber,
      encryptKey: await _encryptionKeyService.getOrCreateKey(),
      boxKey: userUuid,
    );
  }
}
