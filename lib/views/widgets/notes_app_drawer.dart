import 'package:flutter/material.dart';
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
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  children: [
                    SizedBox(height: 16),
                    UserProfile(),
                    Divider(height: 32),
                    QuickSettingsSection()
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
