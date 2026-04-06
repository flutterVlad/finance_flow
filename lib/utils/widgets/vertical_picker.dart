import 'package:flutter/cupertino.dart';

class VerticalPicker<T> extends StatelessWidget {
  const VerticalPicker({
    super.key,
    this.initialItem,
    required this.onSelected,
    required this.items,
    required this.builder,
  }) : assert(items.length != 0, "items not be empty");

  final T? initialItem;
  final void Function(T) onSelected;
  final List<T> items;
  final Widget Function(T) builder;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 40,
      child: CupertinoPicker(
        itemExtent: 30.0,
        onSelectedItemChanged: (index) {
          onSelected(items[index]);
        },
        scrollController: FixedExtentScrollController(
          initialItem: initialItem != null ? items.indexOf(initialItem!) : 0,
        ),
        children: items.map(builder).toList(),
      ),
    );
  }
}
