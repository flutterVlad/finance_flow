import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '/data/models/bank_card/bank_card.dart';
import '/presentation/screens/home_screen/features/settings/bloc/settings_bloc.dart';
import '/utils/svgs/svg.dart';
import '/utils/theme.dart';

class WalletCard extends StatelessWidget {
  final BankCard card;

  const WalletCard({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(12);
    const textStyle = TextStyle(color: AppColors.onPrimary);

    return Padding(
      padding: const .only(top: 40, right: 40, left: 40, bottom: 40),
      child: Material(
        elevation: 3,
        borderRadius: borderRadius,
        child: GestureDetector(
          onLongPress: () {
            GetIt.I<SettingsBloc>().add(RemoveCardEvent(card.number));
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              color: AppColors.primary,
            ),
            padding: const .all(16),
            child: Column(
              crossAxisAlignment: .start,
              mainAxisAlignment: .spaceBetween,
              children: [
                Svg(card.cardIcon),
                Column(
                  crossAxisAlignment: .start,
                  spacing: 8,
                  children: [
                    Text(card.number, style: textStyle),
                    Row(
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        Text(card.owner.toUpperCase(), style: textStyle),
                        Text(card.duration, style: textStyle),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
