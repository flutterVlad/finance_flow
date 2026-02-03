import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CardOwnerInput extends StatefulWidget {
  const CardOwnerInput({
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
  State<CardOwnerInput> createState() => _CardOwnerInputState();
}

class _CardOwnerInputState extends State<CardOwnerInput> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      onFocusChange: (hasFocus) {
        if (!hasFocus) {
          widget.onChanged?.call(_textController.text.toUpperCase());
        }
      },
      child: TextField(
        controller: _textController,
        textInputAction: .next,
        inputFormatters: [
          TextInputFormatter.withFunction(
            (_, newVal) => TextEditingValue(text: newVal.text.toUpperCase()),
          ),
        ],
        decoration: InputDecoration(
          hintText: 'IVAN IVANOV',
          errorText: widget.errorText,
          errorMaxLines: 1,
        ),
        focusNode: widget.focusNode,
        onSubmitted: (_) {
          if (widget.errorText == null) FocusScope.of(context).nextFocus();
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
