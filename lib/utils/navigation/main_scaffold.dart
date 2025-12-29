import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'bottom_bar.dart';

class MainScaffold extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const MainScaffold({super.key, required this.navigationShell});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  final Duration animationDuration = const Duration(milliseconds: 200);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: animationDuration,
      value: 1,
    );
  }

  Future<void> _onItemTapped(int index, BuildContext context) async {
    if (index != widget.navigationShell.currentIndex) {
      await _controller.reverse(from: 1);
    }
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
    if (index != widget.navigationShell.currentIndex) {
      await _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return FadeTransition(
            opacity: CurveTween(curve: Curves.linear).animate(_controller),
            child: child,
          );
        },
        child: widget.navigationShell,
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: BottomBar(
          currentIndex: widget.navigationShell.currentIndex,
          onTap: (index) => _onItemTapped(index, context),
          animationDuration: animationDuration,
        ),
      ),
    );
  }
}
