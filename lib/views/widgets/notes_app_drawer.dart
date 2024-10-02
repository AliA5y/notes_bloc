import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_bloc/cubits/theme_cubit/theme_cubit.dart';
import 'package:notes_bloc/shared.dart';
import 'package:notes_bloc/views/widgets/custom_toggle_switch.dart';

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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Theme',
                          style: Styles.headlineMedium,
                        ),
                        Row(
                          children: [
                            const Text('light'),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Center(
                                child: CustomToggleSwitch(
                                  size: 28,
                                  switchAction: () =>
                                      context.read<ThemeCubit>().toggleTheme(),
                                ),
                              ),
                            ),
                            const Text('dark'),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
