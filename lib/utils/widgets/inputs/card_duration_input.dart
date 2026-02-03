import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CardDurationInput extends StatefulWidget {
  const CardDurationInput({
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
  State<CardDurationInput> createState() => _CardDurationInputState();
}

class _CardDurationInputState extends State<CardDurationInput> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      onFocusChange: (hasFocus) {
        if (!hasFocus) {
          widget.onChanged?.call(_formatExpiryDate(_textController.text));
        }
      },
      child: TextField(
        controller: _textController,
        textInputAction: .next,
        keyboardType: .number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(4),
        ],
        decoration: InputDecoration(
          hintText: 'MM/YY',
          errorText: widget.errorText,
          errorMaxLines: 1,
        ),
        focusNode: widget.focusNode,
        onSubmitted: (_) {
          if (widget.errorText == null) FocusScope.of(context).nextFocus();
        },
        onChanged: (value) {
          setState(() {
            _textController.text = _formatExpiryDate(value);
          });
          widget.onChanged?.call(_formatExpiryDate(value));
        },
        maxLines: 1,
        onTapOutside: (_) => FocusScope.of(context).unfocus(),
      ),
    );
  }

  String _formatExpiryDate(String input) {
    String digitsOnly = input.replaceAll(RegExp(r'\D'), '');
    if (digitsOnly.length > 4) digitsOnly = digitsOnly.substring(0, 4);

    StringBuffer buffer = StringBuffer();
    for (int i = 0; i < digitsOnly.length; i++) {
      if (i > 0 && i % 2 == 0) buffer.write('/');
      buffer.write(digitsOnly[i]);
    }

    return buffer.toString();
  }

  @override
  void dispose() {
    _textController.dispose();

    super.dispose();
  }
}
