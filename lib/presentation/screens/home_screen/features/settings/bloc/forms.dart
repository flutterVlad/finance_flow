import 'package:formz/formz.dart';

class Email extends FormzInput<String?, String> {
  const Email.pure([String? value]) : super.pure(value ?? '');

  const Email.dirty(super.value) : super.dirty();

  @override
  String? validator(String? value) {
    final regExp = RegExp('^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}\$');
    if (value == null) return null;
    if (regExp.hasMatch(value)) return 'Incorrect email format';

    return null;
  }
}

class FirstName extends FormzInput<String?, String> {
  const FirstName.pure([String? value]) : super.pure(value ?? '');

  const FirstName.dirty(super.value) : super.dirty();

  @override
  String? validator(String? value) {
    return null;
  }
}

class LastName extends FormzInput<String?, String> {
  const LastName.pure([String? value]) : super.pure(value ?? '');

  const LastName.dirty(super.value) : super.dirty();

  @override
  String? validator(String? value) {
    return null;
  }
}


