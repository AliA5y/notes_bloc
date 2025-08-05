import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:multiavatar/multiavatar.dart';
import 'package:notes_bloc/features/admin/view_models/cubit/admin_cubit.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is RequestingUsersSuccess) {
            state.users.sort((a, b) {
              final first = a['date'] as Timestamp;
              final second = (b['date'] ?? a['date']) as Timestamp;
              return first.compareTo(second);
            });
          }
          return Scaffold(
              appBar: AppBar(
                title: Text(
                    'Users ${state is RequestingUsersSuccess ? state.users.length : ''}'),
              ),
              body: Padding(
                padding: const EdgeInsets.all(16),
                child: state is RequestingUsersFailure
                    ? Center(
                        child: Text(state.errMessage),
                      )
                    : (state is RequestingUsersSuccess)
                        ? ListView.separated(
                            itemCount: state.users.length,
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 8,
                              );
                            },
                            itemBuilder: (context, index) {
                              final user = state.users[index];
                              final keys = user.keys.toList();
                              final values = user.values.toList();
                              return Card(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: ExpansionTile(
                                    tilePadding: const EdgeInsets.all(8),
                                    childrenPadding: const EdgeInsets.all(0),
                                    title: Row(
                                      children: [
                                        CircleAvatar(
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .primary
                                                .withAlpha(100),
                                            child: SvgPicture.string(
                                                multiavatar(
                                                    '${user['userAvatar']}',
                                                    trBackground: true))),
                                        const SizedBox(width: 8),
                                        Expanded(child: Text(user['id'])),
                                      ],
                                    ),
                                    children: List.generate(keys.length, (i) {
                                      var value = values[i];
                                      if (value is Timestamp) {
                                        value = MyDateTime.toAString(
                                            value.toDate());
                                      }
                                      return Row(
                                        children: [
                                          Expanded(child: Text(keys[i])),
                                          Expanded(
                                              flex: 2,
                                              child: Text(value.toString())),
                                        ],
                                      );
                                    }),
                                  ),
                                ),
                              );
                            },
                          )
                        : const Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          ),
              ));
        });
  }
}

class MyDateTime {
  final String date;
  final String time;

  MyDateTime({required this.date, required this.time});
  factory MyDateTime.fromDateTime(DateTime dateTime) {
    final list = DateFormat().format(dateTime).split(' ');
    final date = list.sublist(0, 3).join(' ');
    final time = list.sublist(3).join(' ');
    return MyDateTime(date: date, time: time);
  }

  static toAString(DateTime dateTime) {
    final list = DateFormat().format(dateTime).split(' ');
    final date = list.sublist(0, 3).join(' ');
    final time = list.sublist(3).join(' ');
    return '$date\n$time';
  }
}
