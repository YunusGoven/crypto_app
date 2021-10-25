import 'package:get_it/get_it.dart';
//import 'package:hybunsinnes/services/api_manager.dart';
import 'package:hybunsinnes/services/navigation_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  //locator.registerLazySingleton(() => ApiManager());
}
