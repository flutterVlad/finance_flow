import 'package:finance_flow/utils/widgets/app_bottom_sheet.dart';
import 'package:flutter/material.dart';

import '/utils/svgs/svgs.dart';
import '/utils/theme.dart';
import '/utils/widgets/app_text_button.dart';
import 'wallet_card.dart';

class CardSwiper extends StatefulWidget {
  const CardSwiper({super.key});

  @override
  State<CardSwiper> createState() => _CardSwiperState();
}

class _CardSwiperState extends State<CardSwiper>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsGeometry.all(16),
      child: SizedBox(
        height: 260,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: .circular(12),
          ),
          child: Stack(
            alignment: .bottomCenter,
            fit: .expand,
            children: [
              PageView(
                onPageChanged: _handlePageViewChanged,
                children: cards.map((el) {
                  return WalletCard(card: el);
                }).toList(),
              ),
              Positioned(
                top: 4,
                right: 4,
                child: AppTextButton(
                  text: '+Add card',
                  color: AppColors.primary500,
                  onPressed: () {
                    AppBottomSheet.show(
                      context: context,
                      isScrollControlled: true,
                      useRootNavigator: true,
                      item: AppBottomSheet.createCard(),
                    );
                  },
                ),
              ),
              Positioned(
                bottom: 5,
                child: TabPageSelector(
                  controller: _tabController,
                  selectedColor: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handlePageViewChanged(int index) {
    _tabController.index = index;
  }
}

final cards = [
  const CardData(
    type: 'Credit card',
    number: '1100 3458 4356 7634',
    owner: 'Vladislav Yurashevich',
    duration: '12/25',
    icon: Svgs.mastercard,
  ),
  const CardData(
    type: 'Debit card',
    number: '1100 4378 9090 2335',
    owner: 'Vladislav Yurashevich',
    duration: '12/25',
    icon: Svgs.visa,
  ),
  const CardData(
    type: 'Debit card',
    number: '3443 2519 4895 9843',
    owner: 'Vladislav Yurashevich',
    duration: '12/25',
    icon: Svgs.mastercard,
  ),
];
