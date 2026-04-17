import 'package:flutter/cupertino.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '/l10n/app_localizations.dart';

part 'card_form.freezed.dart';

enum CardError { empty, invalidCardNumber, invalidFormat, invalidLength }

@freezed
abstract class CardForm with _$CardForm, FormzMixin {
  const CardForm._();

  const factory CardForm({
    @Default(CardNumber.pure()) CardNumber cardNumber,
    @Default(OwnerName.pure()) OwnerName ownerName,
    @Default(CardDuration.pure()) CardDuration duration,
    @Default(CardCVV.pure()) CardCVV cvv,
  }) = _CardForm;

  @override
  List<FormzInput> get inputs => [cardNumber, ownerName, duration, cvv];

  bool get isEmpty =>
      cardNumber.value.isEmpty &&
      ownerName.value.isEmpty &&
      duration.value.isEmpty &&
      cvv.value.isEmpty;
}

class CardNumber extends FormzInput<String, CardError?> with FormzLocalization {
  const CardNumber.pure([String? value]) : super.pure(value ?? '');

  const CardNumber.dirty(super.value) : super.dirty();

  @override
  CardError? validator(String value) {
    if (value.isEmpty) return .empty;
    if (!_validateCard(value)) return .invalidCardNumber;

    return null;
  }

  bool _validateCard(String value) {
    final String number = value.replaceAll(RegExp(r'\D'), '');
    if (number.length < 16) return true;

    int sum = 0;
    bool alternate = false;
    for (int i = number.length - 1; i >= 0; i--) {
      int digit = int.parse(number[i]);
      if (alternate) {
        digit *= 2;
        if (digit > 9) digit -= 9;
      }
      sum += digit;
      alternate = !alternate;
    }

    return sum % 10 == 0;
  }
}

class OwnerName extends FormzInput<String, CardError?> with FormzLocalization {
  const OwnerName.pure([String? value]) : super.pure(value ?? '');

  const OwnerName.dirty(super.value) : super.dirty();

  @override
  CardError? validator(String value) {
    if (value.isEmpty) return .empty;

    return null;
  }
}

class CardDuration extends FormzInput<String, CardError?>
    with FormzLocalization {
  const CardDuration.pure([String? value]) : super.pure(value ?? '');

  const CardDuration.dirty(super.value) : super.dirty();

  @override
  CardError? validator(String value) {
    if (value.isEmpty) return .empty;
    if (!RegExp(
      r'(0[1-9]|1[0-2])/(0[1-9]|[1-2][0-9]|3[0-1])',
    ).hasMatch(value)) {
      return .invalidFormat;
    }

    return null;
  }
}

class CardCVV extends FormzInput<String, CardError?> with FormzLocalization {
  const CardCVV.pure([String? value]) : super.pure(value ?? '');

  const CardCVV.dirty(super.value) : super.dirty();

  @override
  CardError? validator(String value) {
    if (value.isEmpty) return .empty;
    if (value.length < 3) return .invalidLength;

    return null;
  }
}

mixin FormzLocalization on FormzInput<String, CardError?> {
  String? localizeError(BuildContext context) {
    final s = S.of(context);

    return switch (displayError) {
      .empty => s.fieldCanNotBeEmpty,
      .invalidLength => s.invalidLength,
      .invalidFormat => s.invalidFormat,
      .invalidCardNumber => s.invalidCardNumber,
      _ => null,
    };
  }
}
