import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_bloc/cubits/user_cubit/user_cubit.dart';
import 'package:notes_bloc/views/widgets/quick_settings_section.dart';
import 'package:notes_bloc/views/widgets/user_profile.dart';

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
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    BlocProvider(
                      create: (context) => UserCubit()..loadUser(),
                      child: const UserProfile(),
                    ),
                    const Divider(height: 32),
                    const QuickSettingsSection()
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
