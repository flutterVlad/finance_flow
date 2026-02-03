import '/data/models/response/response.dart';
import '/presentation/screens/wallet_screen/entities/card_form.dart';

abstract class CardRepository {
  Future<Response> saveCard(CardForm form);
}
