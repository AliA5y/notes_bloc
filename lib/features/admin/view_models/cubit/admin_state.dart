part of 'admin_cubit.dart';

@immutable
sealed class AdminState {}

final class AdminInitial extends AdminState {}

final class RequestingUsersInProgress extends AdminState {}

final class RequestingConfigsInProgress extends AdminState {}

final class RequestingUsersSuccess extends AdminState {
  final List<Map<String, dynamic>> users;

  RequestingUsersSuccess({required this.users});
}

final class RequestingConfigsSuccess extends AdminState {
  final Map<String, dynamic> configs;
  final bool? configUpdatedSucceded;

  RequestingConfigsSuccess({
    this.configUpdatedSucceded,
    required this.configs,
  });

  RequestingConfigsSuccess copyWith(
      {Map<String, dynamic>? configs, bool? configUpdatedSucceded}) {
    Map<String, dynamic>? map;
    if (configs != null) {
      map = Map.from(this.configs);
      for (final k in configs.keys) {
        if (this.configs.containsKey(k)) {
          map[k] = configs[k];
        }
      }
    }

    return RequestingConfigsSuccess(
      configs: map ?? this.configs,
      configUpdatedSucceded: configUpdatedSucceded,
    );
  }
}

final class RequestingUsersFailure extends AdminState {
  final String errMessage;

  RequestingUsersFailure({required this.errMessage});
}

final class RequestingConfigsFailure extends AdminState {
  final String errMessage;

  RequestingConfigsFailure({required this.errMessage});
}
