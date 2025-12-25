import 'package:flutter/material.dart';

import '/utils/widgets/animated_gradiant_border.dart';

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
                Opacity(
                  opacity: opacity,
                  child: SizedBox(
                    width: 56 * scale,
                    height: 56 * scale,
                    child: AnimatedGradiantBorder(
                      blurRadius: 10,
                      thickness: 2,
                      topColor: Colors.red,
                      bottomColor: Colors.blue,
                      duration: const Duration(seconds: 5),
                      child: ClipRRect(
                        borderRadius: .circular(28 * scale),
                        child: Image.network(
                          'https://cdn.pixabay.com/photo/2021/03/03/10/17/man-6064964_1280.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                // Текст
                Expanded(
                  child: Opacity(
                    opacity: textOpacity.toDouble(),
                    child: Column(
                      crossAxisAlignment: .start,
                      mainAxisAlignment: .center,
                      children: [
                        Text(
                          'Welcome back 👋',
                          style: TextStyle(
                            fontSize: 14 * fontSizeFactor,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          'Vlad Yurashevich',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20 * fontSizeFactor,
                          ),
                        ),
                      ],
                    ),
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
