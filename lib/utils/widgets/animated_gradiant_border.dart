import 'package:flutter/material.dart';

class AnimatedGradiantBorder extends StatefulWidget {
  final double radius;

  final double blurRadius;

  final double spreadRadius;

  final Color topColor;

  final Color bottomColor;

  final double glowOpacity;

  final Duration duration;

  final double thickness;

  final Widget? child;

  const AnimatedGradiantBorder({
    super.key,
    this.radius = 30,
    this.blurRadius = 30,
    this.spreadRadius = 2,
    this.topColor = Colors.red,
    this.bottomColor = Colors.blue,
    this.glowOpacity = 0.3,
    this.duration = const Duration(milliseconds: 500),
    this.thickness = 3,
    this.child,
  });

  @override
  State<AnimatedGradiantBorder> createState() => _AnimatedGradiantBorderState();
}

class _AnimatedGradiantBorderState extends State<AnimatedGradiantBorder>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _progress;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _progress = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
    _controller.repeat();
  }

  Alignment _calculatePosition(double t, double aspectRatio) {
    final topBottomLength = aspectRatio * 2;
    const leftRightLength = 2.0;
    final perimeter = 2 * (topBottomLength + leftRightLength);

    double pos = (t * perimeter) % perimeter;

    if (pos < topBottomLength) {
      double x = pos - aspectRatio;
      return Alignment(x / aspectRatio, -1.0);
    }
    if (pos < leftRightLength + topBottomLength) {
      double y = -1.0 + (pos - topBottomLength);
      return Alignment(1.0, y);
    }
    if (pos < 2 * topBottomLength + leftRightLength) {
      double x = aspectRatio - (pos - topBottomLength - leftRightLength);
      return Alignment(x / aspectRatio, 1.0);
    }
    if (pos < 2 * (leftRightLength + topBottomLength)) {
      double y = 1.0 - (pos - 2 * topBottomLength - leftRightLength);
      return Alignment(-1.0, y);
    }

    return const Alignment(0, 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        final aspectRatio = constrains.maxWidth / constrains.maxHeight;

        return Stack(
          children: [
            widget.child != null
                ? ClipRRect(
                    borderRadius: .circular(widget.radius),
                    child: widget.child,
                  )
                : const SizedBox.shrink(),

            ClipPath(
              clipper: _CenterCutPath(
                radius: widget.radius,
                thickness: widget.thickness,
              ),
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, _) {
                  final begin = _calculatePosition(
                    _progress.value,
                    aspectRatio,
                  );
                  final end = _calculatePosition(
                    (_progress.value + 0.5) % 1.0,
                    aspectRatio,
                  );

                  return Stack(
                    children: [
                      Container(
                        width: constrains.maxWidth,
                        height: constrains.maxHeight,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: .circular(widget.radius),
                          boxShadow: [
                            BoxShadow(
                              color: widget.topColor,
                              offset: Offset.zero,
                              blurRadius: widget.blurRadius,
                              spreadRadius: widget.spreadRadius,
                            ),
                          ],
                        ),
                      ),

                      Align(
                        alignment: end,
                        child: Container(
                          width: constrains.maxWidth * 0.95,
                          height: constrains.maxHeight * 0.95,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: .circular(widget.radius),
                            boxShadow: [
                              BoxShadow(
                                color: widget.bottomColor,
                                offset: Offset.zero,
                                blurRadius: widget.blurRadius,
                                spreadRadius: widget.spreadRadius,
                              ),
                            ],
                          ),
                        ),
                      ),

                      Container(
                        decoration: BoxDecoration(
                          borderRadius: .circular(widget.radius),
                          gradient: LinearGradient(
                            begin: begin,
                            end: end,
                            colors: [widget.topColor, widget.bottomColor],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _CenterCutPath extends CustomClipper<Path> {
  final double radius;
  final double thickness;

  const _CenterCutPath({required this.radius, required this.thickness});

  @override
  Path getClip(Size size) {
    final rect = Rect.fromLTRB(
      -size.width / 2,
      -size.width / 2,
      size.width * 2,
      size.height * 2,
    );
    final width = size.width - thickness;
    final height = size.height - thickness;

    final path = Path()
      ..fillType = PathFillType.evenOdd
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTRB(thickness, thickness, width, height),
          Radius.circular(radius - thickness),
        ),
      )
      ..addRect(rect);

    return path;
  }

  @override
  bool shouldReclip(_CenterCutPath oldClipper) {
    return oldClipper.radius != radius || oldClipper.thickness != thickness;
  }
}
