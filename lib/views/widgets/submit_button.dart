import 'package:flutter/material.dart';
import 'package:notes_bloc/shared.dart';

class SubmittButton extends StatelessWidget {
  const SubmittButton({
    super.key,
    this.onPressed,
    required this.text,
  });
  final void Function()? onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: MaterialButton(
        onPressed: onPressed,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Center(child: Text(text, style: Styles.headlineMedium)),
      ),
    );
  }
}
