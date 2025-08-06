import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Tools {
  static Future<void> showCustomBottomSheet(
    BuildContext context, {
    String? title,
    Widget? body, // Completely custom body content
    Widget? submitButton, // No data passed—just triggers action
    Widget? secondaryButton, // Optional secondary action
    bool centerTitle = true, // Optional secondary action
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            // Handle & Close button
            Stack(
              alignment: AlignmentDirectional.topStart,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 60,
                      height: 6,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Spacer(),
                    InkWell(
                      borderRadius: BorderRadius.circular(50),
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey),
                        ),
                        child: const Icon(Icons.close, size: 20),
                      ),
                    ),
                    const SizedBox(width: 12),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Optional Title
            if (title != null) ...[
              Row(
                mainAxisAlignment: centerTitle
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              const SizedBox(height: 32),
            ],

            // Optional custom body
            if (body != null) ...[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: body,
              ),
              const SizedBox(height: 16),
            ],

            // Optional primary submit button
            if (submitButton != null) ...[
              submitButton,
              const SizedBox(height: 12),
            ],
            // Optional secondary button (e.g. Cancel)
            if (secondaryButton != null) ...[
              secondaryButton,
              const SizedBox(height: 16),
            ],
          ],
        ),
      ),
    );
  }

  static void showCustomSnackbar(
    BuildContext context, {
    required String message,
    String? title,
    NotificationType type = NotificationType.info,
    Duration duration = const Duration(seconds: 5),
    SnackBarAction? action,
    bool dismissible = true,
  }) {
    final color = _getColorByType(type);
    final icon = _getIconByType(type);
    final snackBar = SnackBar(
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 28, color: color),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null)
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                  ),
                Text(
                  message,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      // backgroundColor: AppTheme.getBackground(context),
      behavior: SnackBarBehavior.floating,
      duration: duration,
      action: action,
      elevation: 6.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: color, width: 1.5),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      dismissDirection:
          dismissible ? DismissDirection.down : DismissDirection.none,
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static Color _getColorByType(NotificationType type) {
    switch (type) {
      case NotificationType.success:
        return Colors.green[700]!;
      case NotificationType.warning:
        return Colors.orange[800]!;
      case NotificationType.error:
        return Colors.red[800]!;
      case NotificationType.info:
        return Colors.blue[700]!;
    }
  }

  static IconData _getIconByType(NotificationType type) {
    switch (type) {
      case NotificationType.success:
        return Icons.check_circle;
      case NotificationType.warning:
        return Icons.warning_amber_rounded;
      case NotificationType.error:
        return Icons.error;
      case NotificationType.info:
        return Icons.info;
    }
  }

  static bool isLoading = false;

  static void showLoadingDialog(BuildContext context, {String? message}) {
    if (!isLoading) {
      isLoading = true;
      showDialog(
        context: context,
        barrierDismissible: false, // Prevent closing by tap or back button
        builder: (_) => PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) =>
              false, // Prevent Android back button
          child: Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 300),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Lottie.asset(
                    // 'assets/animations/multi-shape-loader.json',
                    // 'assets/animations/opener-loading.json',
                    // 'assets/animations/reveal-loading.json',
                    // 'assets/animations/multi-shape-loader.json',
                    'assets/animations/Loading.json',
                    repeat: true,
                  ),
                  if (message != null) ...[
                    const SizedBox(height: 12),
                    Text(
                      message,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ]
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

  /// Hide loading dialog
  static void hideLoadingDialog(BuildContext context) {
    if (Navigator.of(context, rootNavigator: true).canPop() && isLoading) {
      Navigator.of(context, rootNavigator: true).pop();
      isLoading = false;
    }
  }
}

enum NotificationType {
  info,
  success,
  warning,
  error,
}
