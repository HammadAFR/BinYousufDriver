import 'package:get_it/get_it.dart';
import '../models/models/user_model.dart';
import '../services/database_services.dart';
import '../services/local_storage_services.dart';
import '../services/notification_service.dart';

GetIt locator = GetIt.instance;

setupLocator() async {
  locator.registerLazySingleton<DatabaseServices>(() => DatabaseServices());
  locator.registerSingleton(LocalStorageService());
  locator.registerSingleton<UserModel>(UserModel());
  locator.registerSingleton(PushNotificationService());

  // locator.registerSingleton(FirebaseDbService());
  // locator.registerSingleton(NotificationsService());
  // locator.registerSingleton<AuthService>(AuthService());
  // locator.registerSingleton<ApiServices>(ApiServices());
  // locator.registerLazySingleton(() => FilePickerService());
}
