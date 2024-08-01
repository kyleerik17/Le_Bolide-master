import 'package:get_it/get_it.dart';
import 'package:le_bolide/data/services/user.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerLazySingleton(() => UserProvider());
}