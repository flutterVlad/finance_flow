import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/di.dart';
import '/l10n/app_localizations.dart';
import '/presentation/bloc/settings/settings_bloc.dart';
import '/presentation/screens/wallet_screen/widgets/create_card_form.dart';
import '/utils/theme.dart';
import '/utils/widgets/app_bottom_sheet.dart';
import '/utils/widgets/app_text_button.dart';
import '/utils/widgets/toast_service.dart';
import 'wallet_card.dart';

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

    final cardsLength = getIt<SettingsBloc>().state.cards.length;

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
    final s = S.of(context);

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
                      : Center(
                          child: Text(
                            s.noCardsAddedYet,
                            style: const TextStyle(color: AppColors.primary500),
                          ),
                        ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: AppTextButton(
                      text: s.addCard,
                      color: AppColors.primary500,
                      onPressed: () {
                        if (state.selectedAccount != null) {
                          AppBottomSheet.show(
                            context: context,
                            isScrollControlled: true,
                            useRootNavigator: true,
                            padding: const .only(top: 16),
                            item: const CreateCardForm(),
                          );
                        } else {
                          ToastService.showToast(
                            message: s.needToCreateAccount,
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
