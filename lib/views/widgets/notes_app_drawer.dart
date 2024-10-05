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
      width: MediaQuery.sizeOf(context).width * 0.7,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      leading: CircleAvatar(
                        backgroundColor:
                            Theme.of(context).colorScheme.inverseSurface,
                        radius: 25,
                        child: const Padding(
                          padding: EdgeInsets.all(2.0),
                          child: CircleAvatar(
                            radius: 20,
                            // child: Container(
                            //   decoration: BoxDecoration(shape: BoxShape.circle),
                            // ),
                          ),
                        ),
                      ),
                      title: const Text('User Name'),
                      subtitle: const Text('email'),
                    ),
                    const Divider(height: 32),
                    QuickToggleSettingTile(
                      switchAction: () =>
                          context.read<ThemeCubit>().toggleTheme(),
                      isSwitched:
                          Theme.of(context).brightness == Brightness.dark,
                      values: {
                        'title': S.of(context).theme,
                        'first': S.of(context).light,
                        'second': S.of(context).dark,
                      },
                    ),
                    const Divider(height: 16),
                    QuickToggleSettingTile(
                      switchAction: () async {
                        if (isArabic()) {
                          context.read<LanguageCubit>().changeLanguage('en');
                        } else {
                          context.read<LanguageCubit>().changeLanguage('ar');
                        }
                        Navigator.pop(context);
                      },
                      isSwitched: !isArabic(),
                      values: {
                        'title': S.of(context).lang,
                        'first': 'العربية',
                        'second': 'English',
                      },
                    )
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
