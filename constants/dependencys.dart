import 'package:get_it/get_it.dart';
import '../interfaces/local_storage_interface.dart';
import '../services/hive_service.dart';
import '../controllers/startup_controller.dart';

class Dependencys {
  Dependencys._();
  static final instance = Dependencys._();
  final getIt = GetIt.instance;
  final LocalStorageInterface localStorage = HiveService('config');

  void init() {
    getIt.registerLazySingleton(() => StartupController(localStorage));
  }
}
