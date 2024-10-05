import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_bloc/cubits/language_cubit/language_cubit.dart';
import 'package:notes_bloc/cubits/theme_cubit/theme_cubit.dart';
import 'package:notes_bloc/generated/l10n.dart';
import 'package:notes_bloc/shared.dart';
import 'package:notes_bloc/views/widgets/quick_toggle_setting_tile.dart';

class NotesAppDrawer extends StatelessWidget {
  const NotesAppDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.sizeOf(context).width * 0.85,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        const SizedBox(height: 16),
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.25,
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius:
                                    MediaQuery.sizeOf(context).height * 0.075,
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .inverseSurface
                                    .withAlpha(100),
                              ),
                              const SizedBox(height: 12),
                              Text('Name', style: Styles.headlineLarge)
                            ],
                          ),
                        ),
                        const Divider(height: 32),
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
                          switchAction: () =>
                              context.read<ThemeCubit>().toggleTheme(),
                          isSwitched:
                              Theme.of(context).brightness == Brightness.dark,
                          values: {
                            'title': S.of(context).theme,
                            'first': isArabic()
                                ? S.of(context).dark
                                : S.of(context).light,
                            'second': isArabic()
                                ? S.of(context).light
                                : S.of(context).dark,
                          },
                        ),
                        const Divider(height: 24),
                        QuickToggleSettingTile(
                          switchAction: () async {
                            if (isArabic()) {
                              context
                                  .read<LanguageCubit>()
                                  .changeLanguage('en');
                            } else {
                              context
                                  .read<LanguageCubit>()
                                  .changeLanguage('ar');
                            }
                          },
                          isSwitched: !isArabic(),
                          values: {
                            'title': S.of(context).lang,
                            'first': isArabic() ? 'English' : 'العربية',
                            'second': isArabic() ? 'العربية' : 'English',
                          },
                        )
                      ],
                    ),
                    Positioned(
                        top: 16,
                        left: 0,
                        right: 0,
                        child: Row(
                          children: [
                            const Spacer(),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.edit,
                                size: 30,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            const SizedBox(width: 16),
                          ],
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
