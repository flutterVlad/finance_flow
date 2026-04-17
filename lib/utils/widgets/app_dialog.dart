import 'package:flutter/material.dart';

import '/l10n/app_localizations.dart';
import '/utils/widgets/primary_button.dart';

abstract class AppDialog {
  static Future<bool> confirmDelete({
    required BuildContext context,
    String? title,
    String? confirmText,
    bool barrierDismissible = true,
  }) async {
    final confirmation = await showGeneralDialog<bool>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierLabel: 'dismiss',
      barrierColor: Colors.black.withValues(alpha: 0.3),
      pageBuilder: (_, _, _) => const SizedBox.shrink(),
      transitionBuilder: (dContext, animation, _, _) {
        final s = S.of(context);

        return BackdropFilter(
          filter: .blur(
            sigmaX: 8 * animation.value,
            sigmaY: 8 * animation.value,
          ),
          child: FadeTransition(
            opacity: animation,
            child: Center(
              child: Material(
                elevation: 3,
                borderRadius: .circular(24),
                color: Colors.white,
                child: SizedBox(
                  width: 300,
                  height: 170,
                  child: Padding(
                    padding: const .all(16),
                    child: Column(
                      spacing: 16,
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        Text(
                          title ?? s.cardDeleted,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: .w600,
                          ),
                          textAlign: .center,
                        ),
                        Row(
                          spacing: 8,
                          children: [
                            Expanded(
                              child: PrimaryButton(
                                onTap: () => Navigator.of(dContext).pop(false),
                                text: s.cancel,
                              ),
                            ),
                            Expanded(
                              child: PrimaryButton(
                                text: confirmText ?? s.confirm,
                                onTap: () => Navigator.of(dContext).pop(true),
                                color: Colors.red,
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
        );
      },
    );

    return confirmation ?? false;
  }
}
