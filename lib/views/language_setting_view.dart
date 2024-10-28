import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_bloc/cubits/language_cubit/language_cubit.dart';
import 'package:notes_bloc/cubits/user_cubit/user_cubit.dart';
import 'package:notes_bloc/generated/l10n.dart';
import 'package:notes_bloc/views/edit_profile_view.dart';
import 'package:notes_bloc/views/widgets/language_chip.dart';
import 'package:notes_bloc/views/widgets/submit_button.dart';

class LanguageSettingView extends StatelessWidget {
  const LanguageSettingView({super.key});
  static const String id = 'language';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                S.of(context).language,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
              LanguageChip(
                language: 'العربية',
                languageLabel: 'ar',
                onPressed: () async {
                  BlocProvider.of<LanguageCubit>(context).changeLanguage('ar');
                },
              ),
              const SizedBox(height: 10),
              LanguageChip(
                language: 'English',
                languageLabel: 'en',
                onPressed: () async {
                  BlocProvider.of<LanguageCubit>(context).changeLanguage('en');
                },
              ),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SubmittButton(
                  maxWidth: 140,
                  text: S.of(context).start,
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BlocProvider(
                                create: (context) => UserCubit()..loadUser(),
                                child: const EditProfileView(
                                  isInitilizing: true,
                                ))));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
