import '/data/models/account/account.dart';
import '/data/models/bank_card/bank_card.dart';
import '/presentation/screens/home_screen/features/settings/bloc/settings_bloc.dart';
import '/presentation/screens/wallet_screen/entities/card_form.dart';

extension FormToAccountMapper on AccountForm {
  Account toDomain() => Account(
    uid: uid,
    email: email.value,
    firstName: firstName.value,
    lastName: lastName.value,
    image: image,
    isPrimary: isPrimary,
  );
}

extension AccountToFormMapper on Account {
  AccountForm toForm() => AccountForm(
    uid: uid,
    email: .pure(email),
    firstName: .pure(firstName),
    lastName: .pure(lastName),
    image: image,
    isPrimary: isPrimary,
  );
}

extension CardFormToModel on CardForm {
  BankCard toModel() => BankCard(
    cardType: BankCard.detectCardType(cardNumber.value),
    number: cardNumber.value,
    owner: ownerName.value,
    duration: duration.value,
    cvv: cvv.value,
  );
}
