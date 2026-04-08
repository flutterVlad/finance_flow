import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '/presentation/screens/home_screen/features/settings/bloc/settings_bloc.dart';
import '/presentation/screens/wallet_screen/widgets/create_card_form.dart';
import '/utils/theme.dart';
import '/utils/widgets/app_bottom_sheet.dart';
import '/utils/widgets/app_text_button.dart';
import '/utils/widgets/toast_service.dart';
import 'wallet_card.dart';

// TODO: Repair widget:
// - add more then one no added card
// - after restart no cards
class CardSwiper extends StatefulWidget {
  const CardSwiper({super.key});

  @override
  State<CardSwiper> createState() => _CardSwiperState();
}

class _CardSwiperState extends State<CardSwiper> with TickerProviderStateMixin {
  late TabController _tabController;
  final _cardsLengthNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();

    final cardsLength = GetIt.I<SettingsBloc>().state.cards.length;

    _tabController = TabController(
      length: cardsLength == 0 ? 1 : cardsLength,
      vsync: this,
    );

    _cardsLengthNotifier.value = cardsLength;
    _cardsLengthNotifier.addListener(_onCardCountChanged);
  }

  void _onCardCountChanged() {
    final newLength = _cardsLengthNotifier.value;
    final controllerLength = newLength == 0 ? 1 : newLength;

    if (_tabController.length != controllerLength) {
      final oldController = _tabController;
      _tabController = TabController(
        length: _cardsLengthNotifier.value,
        vsync: this,
        initialIndex: 0,
      );
      oldController.dispose();
      setState(() {});
    }
  }

  @override
  void dispose() {
    _cardsLengthNotifier.removeListener(_onCardCountChanged);
    _cardsLengthNotifier.dispose();
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
          child: BlocBuilder<SettingsBloc, SettingsState>(
            buildWhen: (prev, curr) {
              return (prev.selectedAccount != curr.selectedAccount) ||
                  (prev.cards != curr.cards);
            },
            builder: (context, state) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _cardsLengthNotifier.value = state.cards.length;
              });

              final hasCards = state.cards.isNotEmpty;

              return Stack(
                alignment: .bottomCenter,
                fit: .expand,
                children: [
                  hasCards
                      ? PageView(
                          onPageChanged: _handlePageViewChanged,
                          children: state.cards.map((el) {
                            return WalletCard(card: el);
                          }).toList(),
                        )
                      : const Center(
                          child: Text(
                            'No cards added yet',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: AppTextButton(
                      text: '+Add card',
                      color: AppColors.primary500,
                      onPressed: () {
                        if (state.selectedAccount != null) {
                          AppBottomSheet.show(
                            context: context,
                            isScrollControlled: true,
                            useRootNavigator: true,
                            isDismissible: true,
                            padding: const .only(top: 16),
                            item: const CreateCardForm(),
                          );
                        } else {
                          ToastService.showToast(
                            message: "Need to create account!",
                            status: .warning,
                          );
                        }
                      },
                    ),
                  ),
                  if (hasCards)
                    Positioned(
                      bottom: 5,
                      child: TabPageSelector(
                        controller: _tabController,
                        selectedColor: AppColors.primary,
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void _handlePageViewChanged(int index) => _tabController.index = index;
}
