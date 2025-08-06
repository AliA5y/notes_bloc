import 'package:flutter/material.dart';
import 'package:notes_bloc/shared.dart';

class SubmittButton extends StatelessWidget {
  const SubmittButton(
      {super.key,
      this.onPressed,
      required this.text,
      this.maxWidth,
      this.isLoading = false,
      this.textStyle,
      this.color});
  final void Function()? onPressed;
  final String text;
  final double? maxWidth;
  final bool isLoading;
  final Color? color;
  final TextStyle? textStyle;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: MaterialButton(
        onPressed: onPressed,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        color: color ?? Theme.of(context).colorScheme.primaryContainer,
        child: SizedBox(
            width: maxWidth,
            child: Center(
              child: isLoading
                  ? const CircularProgressIndicator(
                      strokeWidth: 2,
                    )
                  : Text(text, style: textStyle ?? Styles.headlineLarge),
            )),
      ),
    );
  }
}
