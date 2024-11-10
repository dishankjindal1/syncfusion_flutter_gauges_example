import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pulgas_power/core/auth/auth_service.dart';
import 'package:pulgas_power/core/storage/app_persistent_storage_service.dart';

final getIt = GetIt.I;

Future<void> dependencyInjection() async {
  final appDirectory = await getApplicationDocumentsDirectory();
  final appCacheDirectory = await getApplicationCacheDirectory();

  final appStorage =
      AppPersistentStorageService(appDirectory, appCacheDirectory);
  getIt.registerSingleton(appStorage);

  final authData = AuthData();
  getIt.registerSingleton(authData);
}
