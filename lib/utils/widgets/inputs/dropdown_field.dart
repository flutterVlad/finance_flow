import 'package:flutter/material.dart';

class DropdownField<T> extends StatefulWidget {
  final String label;
  final T? value;
  final String Function(T value) itemLabel;
  final void Function(T value) onChanged;
  final void Function()? onRemove;
  final void Function()? onClose;
  final String? errorText;
  final bool enabled;
  final bool isLoading;
  final Widget item;

  const DropdownField({
    super.key,
    required this.label,
    this.value,
    required this.itemLabel,
    required this.onChanged,
    this.onRemove,
    this.onClose,
    this.errorText,
    this.enabled = true,
    this.isLoading = false,
    required this.item,
  });

  @override
  State<DropdownField<T>> createState() => _DropdownFieldState<T>();
}

class _DropdownFieldState<T> extends State<DropdownField<T>> {
  late final TextEditingController _textController;
  late final FocusNode _focusNode;
  late final ValueNotifier<bool> _menuOpened;

  @override
  void initState() {
    super.initState();
    _menuOpened = ValueNotifier(false);
    _focusNode = FocusNode();
    _textController = TextEditingController(text: _itemLabel);
  }

  @override
  void didUpdateWidget(covariant DropdownField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateTextField(_itemLabel);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _textController.dispose();
    _menuOpened.dispose();
    super.dispose();
  }

  String get _itemLabel => switch (widget.value) {
    null => '',
    T value => widget.itemLabel(value),
  };

  void _setMenuState(bool isOpened) => _menuOpened.value = isOpened;

  String _updateTextField(String text) => _textController.text = text;

  void _onRemove() {
    _updateTextField('');
    widget.onRemove?.call();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textController,
      focusNode: _focusNode,
      enabled: widget.enabled,
      readOnly: true,
      decoration: InputDecoration(
        labelText: widget.label,
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.onRemove != null)
              ListenableBuilder(
                listenable: _textController,
                builder: (_, _) => switch (_textController.text.isNotEmpty) {
                  true => IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: _onRemove,
                  ),
                  false => const SizedBox.shrink(),
                },
              ),
            switch (widget.isLoading) {
              true => const Padding(
                padding: EdgeInsets.all(15),
                child: SizedBox.square(
                  dimension: 18,
                  child: CircularProgressIndicator.adaptive(strokeWidth: 2),
                ),
              ),
              false => const Icon(Icons.keyboard_arrow_down),
            },
          ],
        ),
        errorText: widget.errorText,
        errorMaxLines: 3,
      ),
      onTap: () async {
        _setMenuState(true);

        // T? selectedValue;

        // await showModalBottomSheet(
        //   context: context,
        //   showDragHandle: true,
        //   isScrollControlled: true,
        //   builder: (_) => SafeArea(
        //     child: BottomDropdownMenu(
        //       label: widget.label,
        //       onRemove: widget.onRemove != null ? _onRemove : null,
        //       child: _ListWithSearch<T>(
        //         values: widget.values,
        //         itemLabel: widget.itemLabel,
        //         onChange: (value) => selectedValue = value,
        //       ),
        //     ),
        //   ),
        // );

        // if (selectedValue != null) {
        //   _updateTextField(widget.itemLabel(selectedValue as T));
        //   widget.onChanged(selectedValue as T);
        // } else if (widget.value == null) {
        //   widget.onRemove?.call();
        // }

        _setMenuState(false);

        widget.onClose?.call();
        _focusNode.unfocus();
      },
    );
  }
}
