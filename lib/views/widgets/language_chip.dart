import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_bloc/cubits/language_cubit/language_cubit.dart';

class LanguageChip extends StatelessWidget {
  const LanguageChip({
    super.key,
    required this.language,
    required this.languageLabel,
    this.onPressed,
  });
  final String language;
  final String languageLabel;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    final bool isSelected =
        BlocProvider.of<LanguageCubit>(context).language == languageLabel;
    return MaterialButton(
      padding: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      onPressed: onPressed,
      child: Container(
        width: 120,
        height: 58,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).primaryColor
                : Colors.transparent,
            width: 4,
          ),
        ),
        child: Center(
            child: Text(
          language,
          style: Theme.of(context).textTheme.titleLarge,
        )),
      ),
    );
  }
}
