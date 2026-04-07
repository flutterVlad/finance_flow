import 'package:flutter/material.dart';

enum TextAlignment { right, left, center }

class AnimatedText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlignment textAlignment;

  final bool useLayoutBuilder;

  const AnimatedText({
    super.key,
    required this.text,
    this.style,
    this.useLayoutBuilder = false,
    this.textAlignment = .center,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      layoutBuilder: useLayoutBuilder
          ? (currentChild, previousChildren) {
              return Stack(
                alignment: switch (textAlignment) {
                  .right => .centerRight,
                  .left => .centerLeft,
                  .center => .center,
                },
                children: [
                  ...previousChildren,
                  if (currentChild != null) currentChild,
                ],
              );
            }
          : AnimatedSwitcher.defaultLayoutBuilder,
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.3),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
      child: Text(text, key: ValueKey(text), style: style),
    );
  }
}
