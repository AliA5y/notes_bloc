import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_bloc/features/admin/services/admin_service.dart';

part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit(this.adminService) : super(AdminInitial());
  final AdminService adminService;

  loadUsers() async {
    emit(RequestingUsersInProgress());
    final users =
        await adminService.getAllOnCollectionData(collPath: 'userData');
    if (users != null) {
      emit(RequestingUsersSuccess(users: users));
    } else {
      emit(RequestingUsersFailure(
          errMessage:
              'somthing went wrong, check internt and try again later'));
    }
  }

  loadConfigs() async {
    emit(RequestingConfigsInProgress());
    final configs = await adminService.getData(path: 'settings/configs');
    if (configs != null) {
      emit(RequestingConfigsSuccess(configs: configs));
    } else {
      emit(RequestingConfigsFailure(
          errMessage:
              'somthing went wrong, check internt and try again later'));
    }
  }

  updateConfigValue(Map<String, dynamic> data) async {
    final lastState = state as RequestingConfigsSuccess;
    final hasUpdated =
        await adminService.addData(path: 'settings/configs', data: data);
    if (hasUpdated) {
      emit(
          lastState.copyWith(configUpdatedSucceded: hasUpdated, configs: data));
    } else {
      emit(lastState.copyWith(configUpdatedSucceded: hasUpdated));
    }
  }
}
