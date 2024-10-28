import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:notes_bloc/data/models/user.dart';
import 'package:notes_bloc/generated/l10n.dart';
import 'package:notes_bloc/helpers/request_helper.dart';
import 'package:notes_bloc/helpers/request_states.dart';
import 'package:notes_bloc/shared.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  late User user;
  _initUser() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString(PrefsKeys.nameKey) ?? S.current.userName;
    final avatar = prefs.getInt(PrefsKeys.avatarKey) ?? 15;
    user = User(name: name, avatarCode: avatar);
  }

  loadUser() async {
    emit(UserLoadLoading());
    await _initUser();
    await Future.delayed(const Duration(milliseconds: 10));
    emit(UserloadSuccess(user: user));
  }

  updateUser(User user) async {
    emit(UserUpdateLoading());
    final sp = await SharedPreferences.getInstance();
    sp.setString(PrefsKeys.nameKey, user.name);
    sp.setInt(PrefsKeys.avatarKey, user.avatarCode);
    sp.setBool(PrefsKeys.idInitFlagKey, false);
    final initState = await RequestHelper.handelDeviceId(updateUser: true);
    if (initState is Success) {
      sp.setBool(PrefsKeys.idInitFlagKey, true);
    }
    await Future.delayed(const Duration(milliseconds: 10));
    emit(UserUpdateSuccess(user: user));
  }
}
