import 'package:get_it/get_it.dart';
import '../services/local_storage_services.dart';

GetIt locator = GetIt.instance;

setupLocator() async {
  // locator.registerSingleton<UserModel>(UserModel());
  locator.registerSingleton(LocalStorageService());
  // locator.registerSingleton(FirebaseDbService());
  //
  // locator.registerSingleton(NotificationsService());
  // locator.registerLazySingleton<DatabaseServices>(() => DatabaseServices());
  // locator.registerSingleton<AuthService>(AuthService());
  // locator.registerSingleton<ApiServices>(ApiServices());
  // locator.registerLazySingleton(() => FilePickerService());
}
