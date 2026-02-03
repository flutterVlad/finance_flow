import '/data/models/account/account.dart';
import '/presentation/screens/home_screen/features/settings/bloc/settings_bloc.dart';

extension FormToAccountMapper on AccountForm {
  Account toDomain() => Account(
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
