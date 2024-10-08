import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:notes_bloc/data/models/user.dart';
import 'package:notes_bloc/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  late User user;
  _initUser() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('name') ?? S.current.userName;
    final avatar = prefs.getInt('avatar') ?? 15;
    user = User(name: name, avatarCode: avatar);
  }

  loadUser() async {
    emit(UserLoadLoading());
    await _initUser();
    await Future.delayed(const Duration(milliseconds: 10));
    emit(UserloadSuccess(user: user));
  }
}
