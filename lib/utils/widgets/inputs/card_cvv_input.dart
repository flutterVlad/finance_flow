import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CardCVVInput extends StatefulWidget {
  const CardCVVInput({
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
  State<CardCVVInput> createState() => _CardCVVInputState();
}

class _CardCVVInputState extends State<CardCVVInput> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      onFocusChange: (hasFocus) {
        if (!hasFocus) {
          widget.onChanged?.call(_textController.text);
        }
      },
      child: TextField(
        controller: _textController,
        textInputAction: .done,
        keyboardType: .number,
        inputFormatters: [LengthLimitingTextInputFormatter(3)],
        decoration: InputDecoration(
          hintText: '000',
          errorText: widget.errorText,
          errorMaxLines: 1,
        ),
        focusNode: widget.focusNode,
        onSubmitted: (_) {
          if (widget.errorText == null) FocusScope.of(context).unfocus();
        },
        onChanged: (value) {
          widget.onChanged?.call(value.toUpperCase());
        },
        maxLines: 1,
        onTapOutside: (_) => FocusScope.of(context).unfocus(),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();

    super.dispose();
  }
}
