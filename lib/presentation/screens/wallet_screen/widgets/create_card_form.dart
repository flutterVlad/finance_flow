import 'package:finance_flow/utils/widgets/primary_button.dart';
import 'package:flutter/material.dart';

import '/presentation/screens/wallet_screen/entities/card_form.dart';
import '/utils/theme.dart';
import '/utils/widgets/inputs/card_cvv_input.dart';
import '/utils/widgets/inputs/card_duration_input.dart';
import '/utils/widgets/inputs/card_number_input.dart';
import '/utils/widgets/inputs/card_owner_input.dart';

class CreateCardForm extends StatefulWidget {
  const CreateCardForm({super.key, this.form});

  final CardForm? form;

  @override
  State<CreateCardForm> createState() => _CreateCardFormState();
}

class _CreateCardFormState extends State<CreateCardForm> {
  late final ValueNotifier<CardForm> formNotifier;

  @override
  void initState() {
    super.initState();

    formNotifier = ValueNotifier(widget.form ?? const CardForm());
  }

  @override
  void dispose() {
    formNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const .only(right: 16, left: 16, bottom: 16),
        child: Column(
          spacing: 16,
          mainAxisSize: .min,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: .circular(20),
                color: AppColors.onPrimary,
                border: .all(color: AppColors.lightGrey, width: 1),
              ),
              child: ClipRRect(
                borderRadius: .circular(20),
                child: Column(
                  mainAxisSize: .min,
                  children: [
                    CardNumber(formNotifier: formNotifier),
                    const Divider(height: 0, color: AppColors.lightGrey),
                    CardOwner(formNotifier: formNotifier),
                    const Divider(height: 0, color: AppColors.lightGrey),
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(
                            child: CardDuration(formNotifier: formNotifier),
                          ),
                          const VerticalDivider(
                            thickness: 1,
                            color: AppColors.lightGrey,
                          ),
                          Expanded(child: CardCVV(formNotifier: formNotifier)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ValueListenableBuilder(
              valueListenable: formNotifier,
              builder: (context, form, _) => PrimaryButton(
                enabled: form.isValid,
                onTap: () {},
                text: 'Submit',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardNumber extends StatelessWidget {
  const CardNumber({super.key, required this.formNotifier});

  final ValueNotifier<CardForm> formNotifier;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: formNotifier,
      builder: (context, form, _) {
        return CardNumberInput(
          text: form.cardNumber.value,
          errorText: form.cardNumber.displayError,
          onChanged: (value) {
            formNotifier.value = form.copyWith(cardNumber: .dirty(value));
          },
        );
      },
    );
  }
}

class CardOwner extends StatelessWidget {
  const CardOwner({super.key, required this.formNotifier});

  final ValueNotifier<CardForm> formNotifier;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: formNotifier,
      builder: (context, form, _) {
        return CardOwnerInput(
          text: form.ownerName.value,
          errorText: form.ownerName.displayError,
          onChanged: (value) {
            formNotifier.value = form.copyWith(ownerName: .dirty(value));
          },
        );
      },
    );
  }
}

class CardDuration extends StatelessWidget {
  const CardDuration({super.key, required this.formNotifier});

  final ValueNotifier<CardForm> formNotifier;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: formNotifier,
      builder: (context, form, _) {
        return CardDurationInput(
          text: form.duration.value,
          errorText: form.duration.displayError,
          onChanged: (value) {
            formNotifier.value = form.copyWith(duration: .dirty(value));
          },
        );
      },
    );
  }
}

class CardCVV extends StatelessWidget {
  const CardCVV({super.key, required this.formNotifier});

  final ValueNotifier<CardForm> formNotifier;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: formNotifier,
      builder: (context, form, _) {
        return CardCVVInput(
          text: form.cvv.value,
          errorText: form.cvv.displayError,
          onChanged: (value) {
            formNotifier.value = form.copyWith(cvv: .dirty(value));
          },
        );
      },
    );
  }
}
