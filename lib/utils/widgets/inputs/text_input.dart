import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextInput extends StatefulWidget {
  const TextInput({
    super.key,
    String? text,
    this.labelText,
    this.enabled = true,
    this.readOnly = false,
    this.inputFormatters = const [],
    this.onChanged,
    this.onTap,
    this.errorText,
    this.keyboardType,
    this.focusNode,
    this.maxLines = 1,
    this.minLines,
    this.suffixText,
  }) : text = text ?? '';

  final String text;
  final String? labelText;
  final bool enabled;
  final bool readOnly;
  final TextInputType? keyboardType;
  final List<TextInputFormatter> inputFormatters;
  final FocusNode? focusNode;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final String? errorText;
  final int? maxLines;
  final int? minLines;
  final String? suffixText;

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _updateTextIfNeeded();
  }

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      onFocusChange: (hasFocus) {
        if (!hasFocus) {
          widget.onChanged?.call(_textController.text);
        }
      },
      child: TextField(
        readOnly: widget.readOnly,
        enabled: widget.enabled,
        controller: _textController,
        inputFormatters: widget.inputFormatters,
        decoration: InputDecoration(
          suffixText: widget.suffixText,
          labelText: widget.labelText,
          suffixIcon: ValueListenableBuilder(
            valueListenable: _textController,
            builder: (context, value, _) => switch (value.text.isNotEmpty) {
              true => IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _textController.clear();
                  widget.onChanged?.call('');
                },
              ),
              false => const SizedBox.shrink(),
            },
          ),
          errorText: widget.errorText,
          errorMaxLines: 3,
        ),
        focusNode: widget.focusNode,
        keyboardType: widget.keyboardType,
        onTap: widget.onTap,
        onChanged: widget.onChanged,
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        onTapOutside: (_) => FocusScope.of(context).unfocus(),
      ),
    );
  }

  @override
  void didUpdateWidget(covariant TextInput oldWidget) {
    _updateTextIfNeeded();

    super.didUpdateWidget(oldWidget);
  }

  void _updateTextIfNeeded() {
    if (_textController.text != widget.text) {
      _textController.text = widget.text;
    }
  }

  @override
  void dispose() {
    _textController.dispose();

    super.dispose();
  }
}
