import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_bloc/cubits/language_cubit/language_cubit.dart';
import 'package:notes_bloc/cubits/theme_cubit/theme_cubit.dart';
import 'package:notes_bloc/generated/l10n.dart';
import 'package:notes_bloc/shared.dart';
import 'package:notes_bloc/views/widgets/quick_toggle_setting_tile.dart';

class QuickSettingsSection extends StatelessWidget {
  const QuickSettingsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              S.of(context).quickSett,
              textAlign: TextAlign.start,
              style: Styles.headlineMedium,
            ),
          ],
        ),
        const Divider(height: 24),
        QuickToggleSettingTile(
          switchAction: () => context.read<ThemeCubit>().toggleTheme(),
          isSwitched: Theme.of(context).brightness == Brightness.dark,
          values: {
            'title': S.of(context).theme,
            'first': isArabic() ? S.of(context).dark : S.of(context).light,
            'second': isArabic() ? S.of(context).light : S.of(context).dark,
          },
        ),
        const Divider(height: 24),
        QuickToggleSettingTile(
          switchAction: () async {
            if (isArabic()) {
              context.read<LanguageCubit>().changeLanguage('en');
            } else {
              context.read<LanguageCubit>().changeLanguage('ar');
            }
          },
          isSwitched: !isArabic(),
          values: {
            'title': S.of(context).lang,
            'first': isArabic() ? 'English' : 'العربية',
            'second': isArabic() ? 'العربية' : 'English',
          },
        ),
      ],
    );
  }
}
