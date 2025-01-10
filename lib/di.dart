import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pulgas_power/core/auth/auth_data.dart';
import 'package:pulgas_power/core/storage/app_persistent_storage_service.dart';

final getIt = GetIt.I;

Future<void> dependencyInjection() async {
  final appDirectory = await getApplicationDocumentsDirectory();
  final appCacheDirectory = await getApplicationCacheDirectory();

  final appStorage =
      AppPersistentStorageService(appDirectory, appCacheDirectory);
  await appStorage.initalize();
  getIt.registerSingleton(appStorage);

  final authData = AuthData.fromJson(appStorage.appStorage);
  getIt.registerSingleton(authData);
}
