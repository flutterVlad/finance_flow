import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '/presentation/screens/home_screen/features/settings/bloc/settings_bloc.dart';
import '/presentation/screens/home_screen/widgets/avatar_view.dart';

class BlurAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;

  const BlurAppBarDelegate({required this.minHeight, required this.maxHeight});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final safeShrinkOffset = shrinkOffset.clamp(0, maxExtent - minExtent);

    final difference = maxExtent - minExtent;
    final shrinkRatio = difference > 0 ? safeShrinkOffset / difference : 0;

    final opacity = (1.0 - (shrinkRatio * 0.5)).clamp(0.3, 1.0);
    final scale = (1 - shrinkRatio * 0.3).clamp(0.7, 1.0);
    final textOpacity = (1 - shrinkRatio).clamp(0.5, 1.0);
    final fontSizeFactor = (1 - shrinkRatio * 0.3).clamp(0.8, 1.0);

    final colorScheme = Theme.of(context).colorScheme;

    return ClipRRect(
      borderRadius: const .vertical(bottom: .circular(32)),
      child: Stack(
        children: [
          Positioned.fill(
            child: BackdropFilter(
              filter: .blur(sigmaX: 10 * opacity, sigmaY: 10 * opacity),
              child: Container(
                decoration: BoxDecoration(
                  color: colorScheme.secondary.withValues(alpha: .8 * opacity),
                ),
              ),
            ),
          ),

          Padding(
            padding: .only(
              left: 16,
              right: 16,
              top: 8 + MediaQuery.paddingOf(context).top,
              bottom: 8,
            ),
            child: Row(
              crossAxisAlignment: .center,
              children: [
                // Аватар
                AvatarView(
                  onTap: () {
                    context.pushNamed('settings');
                  },
                  opacity: opacity,
                  imageSize: 56 * scale,
                  blurRadius: 10,
                  thickness: 2,
                ),

                const SizedBox(width: 16),

                // Текст
                Expanded(
                  child: _AppBarTitle(
                    opacity: textOpacity.toDouble(),
                    fontSizeFactor: fontSizeFactor,
                  ),
                ),

                // Иконки
                Opacity(
                  opacity: opacity,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.search, size: 24 * scale),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Badge(
                          child: Icon(
                            Icons.notifications_none,
                            size: 24 * scale,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(BlurAppBarDelegate oldDelegate) {
    return oldDelegate.minHeight != minHeight ||
        oldDelegate.maxHeight != maxHeight;
  }
}

class _AppBarTitle extends StatelessWidget {
  const _AppBarTitle({this.opacity = 1, this.fontSizeFactor = 1});

  final double opacity;
  final double fontSizeFactor;

  @override
  Widget build(BuildContext context) {
    final account = context.select(
      (SettingsBloc bloc) => bloc.state.selectedAccount,
    );
    final isFullInfo = account != null;

    final fontSize = isFullInfo ? 14 : 18;
    final textColor = isFullInfo ? Colors.grey : null;
    final fontWeight = isFullInfo ? null : FontWeight.bold;

    return Opacity(
      opacity: opacity,
      child: Column(
        crossAxisAlignment: .start,
        mainAxisAlignment: .center,
        children: [
          Text(
            'Welcome back 👋',
            style: TextStyle(
              fontSize: fontSize * fontSizeFactor,
              color: textColor,
              fontWeight: fontWeight,
            ),
          ),
          if (isFullInfo)
            Text(
              '${account.firstName} ${account.lastName}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20 * fontSizeFactor,
              ),
            ),
        ],
      ),
    );
  }
}
