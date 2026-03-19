import '/data/models/bank_card/bank_card.dart';
import '/data/models/response/response.dart';
import '/presentation/screens/wallet_screen/entities/card_form.dart';

abstract class CardRepository {
  Future<Response> saveCard(CardForm form, String userUuid);

  Future<List<BankCard>> getCards(String userUuid);

  Future<Response> deleteCard(String cardNumber, String userUuid);
}
