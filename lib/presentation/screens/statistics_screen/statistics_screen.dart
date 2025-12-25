import 'package:finance_flow/utils/theme.dart';
import 'package:flutter/material.dart';

import 'features/remaining_statistics/remaining_statistics.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          title: const Text('Budget', style: TextStyle(fontWeight: .bold)),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                borderRadius: .circular(30),
                color: AppColors.primary,
              ),
              child: const TabBar(
                indicatorPadding: .all(4),
                tabs: [
                  TabItem(text: 'Plan', height: 30, width: 70),
                  TabItem(text: 'Remaining', height: 30, width: 70),
                ],
              ),
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            Center(child: Text('First')),
            RemainingStatistics(),
          ],
        ),
      ),
    );
  }
}

class TabItem extends StatelessWidget {
  final String text;

  final double? width;

  final double? height;

  const TabItem({super.key, this.text = '', this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Tab(text: text, height: height),
    );
  }
}
