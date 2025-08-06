import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_bloc/features/admin/view_models/cubit/admin_cubit.dart';
import 'package:notes_bloc/features/admin/views/widgets/field_editing_dialog.dart';

class ConfigsScreen extends StatelessWidget {
  const ConfigsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Configs'),
        ),
        body: BlocConsumer<AdminCubit, AdminState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is RequestingConfigsFailure) {
              return Center(
                child: Text(state.errMessage),
              );
            } else if (state is RequestingConfigsSuccess) {
              return ListView.builder(
                itemCount: state.configs.length,
                itemBuilder: (context, index) {
                  final keys = state.configs.keys.toList();
                  final values = state.configs.values.toList();
                  return ListTile(
                    title: Text(keys[index]),
                    subtitle: Text(values[index].toString()),
                    trailing: IconButton(
                      onPressed: () {
                        String valueToEdite = '';
                        showActionDialog(
                          context: context,
                          dialog: EditFieldsDialog(
                            onChanged: (value) {
                              valueToEdite = value;
                            },
                            onConfirm: () async {
                              if (valueToEdite.isNotEmpty) {
                                num? numaric;
                                String? text;
                                try {
                                  numaric = num.parse(valueToEdite);
                                } catch (_) {
                                  text = valueToEdite;
                                }
                                await context
                                    .read<AdminCubit>()
                                    .updateConfigValue(
                                        {keys[index]: numaric ?? text});
                                Navigator.pop(context);
                              }
                            },
                          ),
                        );
                      },
                      icon: const Icon(Icons.edit),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              );
            }
          },
        ));
  }

  showActionDialog({required BuildContext context, required Widget dialog}) {
    showDialog(
      context: context,
      builder: (context) {
        return dialog;
      },
    );
  }
}
