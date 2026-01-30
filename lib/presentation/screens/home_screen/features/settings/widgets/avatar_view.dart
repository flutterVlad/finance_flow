import 'dart:typed_data';

import 'package:finance_flow/presentation/screens/home_screen/features/settings/bloc/settings_bloc.dart';
import 'package:finance_flow/utils/extensions.dart';
import 'package:finance_flow/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AvatarView extends StatelessWidget {
  const AvatarView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        final Widget image;

        if (state.account != null) {
          image = Image.memory(
            Uint8List.fromList(state.account!.image?.toList() ?? []),
            errorBuilder: (_, _, _) {
              return const ColoredBox(color: AppColors.primary);
            },
          );
        } else {
          image = const ColoredBox(color: AppColors.primary);
        }

        return SizedBox(
          height: 150,
          child: Center(
            heightFactor: 0.1,
            child: Stack(
              children: [
                SizedBox(
                  width: 80,
                  height: 80,
                  child: ClipRRect(borderRadius: .circular(40), child: image),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      color: AppColors.lightGrey.light(0.05),
                      borderRadius: .circular(20),
                      border: Border.all(color: AppColors.secondary, width: 1),
                    ),
                    child: const Center(
                      child: Icon(Icons.edit, color: AppColors.grey, size: 15),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
