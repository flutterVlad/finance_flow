import 'package:flutter/material.dart';

import '/utils/svgs/svg.dart';
import '/utils/theme.dart';

class WalletCard extends StatelessWidget {
  final CardData card;

  const WalletCard({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(12);
    const textStyle = TextStyle(color: AppColors.onPrimary);

    return Padding(
      padding: const .only(top: 48, right: 40, left: 40, bottom: 40),
      child: Material(
        elevation: 3,
        borderRadius: borderRadius,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: AppColors.primary,
          ),
          padding: const .all(16),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Svg(card.icon),
              const SizedBox(height: 20),
              Text(card.type, style: textStyle),
              Text(card.number, style: textStyle),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Text(card.owner.toUpperCase(), style: textStyle),
                  Text(card.duration, style: textStyle),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardData {
  final String type;
  final String number;
  final String owner;
  final String duration;
  final SvgData icon;

  const CardData({
    required this.type,
    required this.number,
    required this.owner,
    required this.duration,
    required this.icon,
  });
}
