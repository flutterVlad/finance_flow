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
    return SvgPicture.asset(
      icon.asset,
      colorFilter: color != null
          ? ColorFilter.mode(color!, BlendMode.srcIn)
          : null,
      width: size ?? icon.size,
      height: size ?? icon.size,
    );
  }
}
