import 'package:flutter/material.dart';
import 'package:notes_bloc/shared.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: 180,
      child: Stack(
        children: [
          Column(
            children: [
              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Theme.of(context)
                      .colorScheme
                      .inverseSurface
                      .withAlpha(100),
                ),
              ),
              const SizedBox(height: 12),
              const Text('Name', style: Styles.headlineLarge)
            ],
          ),
          Positioned(
              top: 0,
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
              )),
        ],
      ),
    );
  }
}
