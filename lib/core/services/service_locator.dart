import 'package:get_it/get_it.dart';
import 'package:notes_bloc/features/admin/services/admin_service.dart';

abstract class Servicelocator {
  static final getIt = GetIt.instance;
  static setup() {
    getIt.registerLazySingleton<AdminService>(() => AdminService());
  }
}
