import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'svgs.dart';

class Svg extends StatelessWidget {
  final SvgData icon;
  final Color? color;
  final double? size;

  const Svg(this.icon, {super.key, this.color, this.size});

  @override
  Widget build(BuildContext context) {
    final colorFilter = color != null
        ? ColorFilter.mode(color!, BlendMode.srcIn)
        : icon.color != null
        ? ColorFilter.mode(icon.color!, BlendMode.srcIn)
        : null;

    return SvgPicture.asset(
      icon.asset,
      colorFilter: colorFilter,
      width: size ?? icon.size,
      height: size ?? icon.size,
    );
  }
}
