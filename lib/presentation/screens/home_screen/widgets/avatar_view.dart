import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/presentation/screens/home_screen/features/settings/bloc/settings_bloc.dart';
import '/utils/theme.dart';
import '/utils/widgets/animated_gradiant_border.dart';

class AvatarView extends StatelessWidget {
  const AvatarView({
    super.key,
    this.image,
    this.onTap,
    this.opacity = 1,
    this.imageSize = 56,
    this.isPreview = true,
    this.editIconSize = 25,
    this.thickness,
    this.blurRadius,
  }) : assert(imageSize > 0, 'imageSize not can be a zero or less'),
       assert(editIconSize > 0, 'editIconSize not cat be a zero or less');

  final double opacity;
  final bool isPreview;
  final Uint8List? image;
  final VoidCallback? onTap;
  final double imageSize;
  final double editIconSize;
  final double? thickness;
  final double? blurRadius;

  @override
  Widget build(BuildContext context) {
    final account = context.select(
      (SettingsBloc bloc) => bloc.state.selectedAccount,
    );

    final Widget icon;

    if (image != null) {
      icon = Image.memory(
        Uint8List.fromList(image!.toList()),
        fit: .cover,
        errorBuilder: (_, _, _) {
          return const ColoredBox(color: AppColors.onPrimary);
        },
      );
    } else if (account?.image != null) {
      icon = Image.memory(
        Uint8List.fromList(account!.image!),
        fit: .cover,
        errorBuilder: (_, _, _) {
          return const ColoredBox(color: AppColors.onPrimary);
        },
      );
    } else {
      icon = const ColoredBox(
        color: AppColors.onPrimary,
        child: Icon(Icons.person),
      );
    }

    final child = isPreview
        ? AnimatedGradiantBorder(
            blurRadius: blurRadius ?? 15,
            thickness: thickness ?? 3,
            radius: imageSize / 2,
            duration: const Duration(seconds: 5),
            child: icon,
          )
        : Stack(
            children: [
              AnimatedGradiantBorder(
                blurRadius: 15,
                thickness: 3,
                radius: imageSize / 2,
                duration: const Duration(seconds: 5),
                child: icon,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: _EditBudget(size: editIconSize),
              ),
            ],
          );

    return GestureDetector(
      behavior: .opaque,
      onTap: onTap,
      child: Opacity(
        opacity: opacity,
        child: SizedBox(height: imageSize, width: imageSize, child: child),
      ),
    );
  }
}

class _EditBudget extends StatelessWidget {
  const _EditBudget({this.size = 20});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: .circular(size / 2),
        border: .all(color: AppColors.secondary, width: 1),
      ),
      child: Center(
        child: Icon(Icons.edit, color: AppColors.grey, size: size * 2 / 3),
      ),
    );
  }
}
