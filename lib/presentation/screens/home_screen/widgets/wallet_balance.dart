import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/presentation/screens/home_screen/bloc/home_bloc.dart';
import '/utils/widgets/gradient_progress_bar.dart';

class WalletBalance extends StatelessWidget {
  const WalletBalance({super.key});

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(16);
    final primaryColor = Theme.of(context).colorScheme.primary;

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) => Padding(
        padding: const .symmetric(horizontal: 16, vertical: 8),
        child: Material(
          borderRadius: borderRadius,
          elevation: 5,
          child: ClipRRect(
            borderRadius: borderRadius,
            child: InkWell(
              borderRadius: borderRadius,
              onTap: () {},
              child: Container(
                color: primaryColor,
                child: BackdropFilter(
                  filter: .blur(sigmaX: 2, sigmaY: 2),
                  child: Padding(
                    padding: const .symmetric(horizontal: 16, vertical: 24),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: .start,
                          mainAxisAlignment: .spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: .start,
                              children: [
                                const Text(
                                  'Wallet Balance',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  '${state.allSpends.toStringAsFixed(2)} Br',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: .bold,
                                  ),
                                ),
                              ],
                            ),
                            const Icon(
                              Icons.arrow_circle_right_outlined,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        GradientProgressBar(percent: state.percent),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: .spaceBetween,
                          children: [
                            Text(
                              'Spent ${state.allSpends.toStringAsFixed(2)} Br',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              'Budget ${state.balance} Br',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
