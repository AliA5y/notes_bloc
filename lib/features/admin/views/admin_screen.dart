import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_bloc/core/services/service_locator.dart';
import 'package:notes_bloc/features/admin/services/admin_service.dart';
import 'package:notes_bloc/features/admin/view_models/cubit/admin_cubit.dart';
import 'package:notes_bloc/features/admin/views/configs_screen.dart';
import 'package:notes_bloc/features/admin/views/users_screen.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AdminPageListItem(
            label: 'Configurations',
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) =>
                          AdminCubit(Servicelocator.getIt.get<AdminService>())
                            ..loadConfigs(),
                      child: const ConfigsScreen(),
                    ),
                  ));
            },
          ),
          const SizedBox(height: 8),
          AdminPageListItem(
            label: 'Users',
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) =>
                          AdminCubit(Servicelocator.getIt.get<AdminService>())
                            ..loadUsers(),
                      child: const UsersScreen(),
                    ),
                  ));
            },
          ),
        ],
      )),
    );
  }
}

class AdminPageListItem extends StatelessWidget {
  const AdminPageListItem({
    super.key,
    this.onTap,
    required this.label,
  });
  final void Function()? onTap;
  final String label;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Center(
            child: Text(
          label,
          style: const TextStyle(fontSize: 32),
        )),
      ),
    );
  }
}
