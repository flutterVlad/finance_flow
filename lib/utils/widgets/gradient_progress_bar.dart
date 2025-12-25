import 'package:flutter/material.dart';

class GradientProgressBar extends StatefulWidget {
  final double persent;
  const GradientProgressBar({super.key, this.persent = 0.0});

  @override
  State<GradientProgressBar> createState() => _GradientProgressBarState();
}

class _GradientProgressBarState extends State<GradientProgressBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<Color?> _animationColor;
  late Animation<double> _animationValue;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _animationValue = Tween<double>(begin: 0, end: widget.persent).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutCirc),
    );

    _animationColor = _animationValue.drive(
      ColorTweenSequence(
        colors: [Colors.green, Colors.yellow, Colors.red],
        stops: [0.0, 0.5, 1.0],
      ),
    );

    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant GradientProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.persent != widget.persent) {
      _animationValue = Tween<double>(begin: 0, end: widget.persent).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOutCirc),
      );
      _animationColor = _animationValue.drive(
        ColorTweenSequence(
          colors: [Colors.green, Colors.yellow, Colors.red],
          stops: [0.0, 0.5, 1.0],
        ),
      );
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationColor,
      builder: (_, _) {
        return LinearProgressIndicator(
          valueColor: _animationColor,
          value: _animationValue.value,
          backgroundColor: Colors.white,
          borderRadius: .circular(4),
          minHeight: 8,
        );
      },
    );
  }
}

class ColorTweenSequence extends Tween<Color?> {
  final List<Color> colors;
  final List<double> stops;

  ColorTweenSequence({required this.colors, required this.stops})
    : assert(colors.length == stops.length);

  @override
  Color? lerp(double t) {
    for (int i = 0; i < stops.length - 1; i++) {
      if (t >= stops[i] && t <= stops[i + 1]) {
        final segmentT = (t - stops[i]) / (stops[i + 1] - stops[i]);
        return Color.lerp(colors[i], colors[i + 1], segmentT);
      }
    }
    return colors.last;
  }
}
