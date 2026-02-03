import 'package:finance_flow/data/models/bank_card/bank_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/utils/svgs/svg.dart';

class CardNumberInput extends StatefulWidget {
  const CardNumberInput({
    super.key,
    String? text,
    this.onChanged,
    this.errorText,
    this.focusNode,
  }) : text = text ?? '';

  final String text;
  final FocusNode? focusNode;
  final void Function(String)? onChanged;
  final String? errorText;

  @override
  State<CardNumberInput> createState() => _CardInputState();
}

class _CardInputState extends State<CardNumberInput> {
  final TextEditingController _textController = TextEditingController();
  late CardType _cardType;
  String? _errorText;

  @override
  void initState() {
    super.initState();

    _errorText = widget.errorText;
    _cardType = CardType.unknown;
  }

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      onFocusChange: (hasFocus) {
        if (!hasFocus) {
          _onSubmit(_textController.text);
          if (_errorText == null) widget.onChanged?.call(_textController.text);
        }
      },
      child: TextField(
        controller: _textController,
        textInputAction: .next,
        keyboardType: .number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(16),
        ],
        decoration: InputDecoration(
          hintText: '0000 0000 0000 0000',
          suffixIcon: Padding(
            padding: const .only(right: 12),
            child: Svg(switch (_cardType) {
              CardType.visa => Svgs.visa,
              CardType.mastercard => Svgs.mastercard,
              CardType.mir => Svgs.mir,
              CardType.belcard => Svgs.belcard,
              CardType.unionPay => Svgs.unionPay,
              CardType.unknown => Svgs.unknownCard,
            }),
          ),
          errorText: _errorText,
          errorMaxLines: 1,
        ),
        focusNode: widget.focusNode,
        onSubmitted: (value) {
          _onSubmit(value);
          if (_errorText == null) FocusScope.of(context).nextFocus();
        },
        onChanged: (value) {
          setState(() {
            _textController.text = BankCard.formatStringWithReplace(
              value: value,
              length: 16,
              replace: (' ', 4),
            );
            _cardType = _detectCardType(value);
          });
          widget.onChanged?.call(value);
        },
        maxLines: 1,
        onTapOutside: (_) => FocusScope.of(context).unfocus(),
      ),
    );
  }

  void _onSubmit(String value) {
    setState(() {
      _errorText = _validateLength(value) ?? widget.errorText;
    });
  }

  String? _validateLength(String value) {
    if (value.replaceAll(' ', '').length != 16) {
      return 'Invalid length (must be 16 numbers)';
    }
    return null;
  }

  CardType _detectCardType(String number) {
    String cleanNumber = number.replaceAll(RegExp(r'\D'), '');

    if (cleanNumber.startsWith('4')) return CardType.visa;
    if (cleanNumber.startsWith(RegExp(r'220[0-4]'))) return CardType.mir;
    if (cleanNumber.startsWith('9112') || cleanNumber.startsWith('6033')) {
      return CardType.belcard;
    }
    if (cleanNumber.startsWith(RegExp(r'5[1-5]')) ||
        cleanNumber.startsWith(
          RegExp(r'222[1-9]|22[3-9]|2[3-6]|27[0-1]|2720'),
        )) {
      return CardType.mastercard;
    }
    if (cleanNumber.startsWith('62')) return CardType.unionPay;
    return CardType.unknown;
  }

  @override
  void didUpdateWidget(covariant CardNumberInput oldWidget) {
    setState(() {
      _errorText = widget.errorText;
    });
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _textController.dispose();

    super.dispose();
  }
}
