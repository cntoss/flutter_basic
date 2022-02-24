// Package imports:
import 'package:get_it/get_it.dart';

// Project imports:
import '../environments/environmentBloc.dart';
import '../helper/size_config.dart';
import '../helper/ui_helper.dart';
import '../login/repository/login_repository.dart';
import '../repository/api.dart';

export '../environments/environmentModel.dart';
export '../environments/environmentBloc.dart';
export '../login/repository/login_repository.dart';
export '../repository/api.dart';
export '../helper/size_config.dart';
export '../helper/ui_helper.dart';

GetIt locator = GetIt.instance;

void setLocator() {
  //?App Helpers
  locator.registerLazySingleton(() => SizeConfig());
  locator.registerLazySingleton(() => UiHelper());

  //?BLoC
  locator.registerLazySingleton(() => EnvironmentBloc());

  //*Factory classes
  locator.registerLazySingleton(() => LoginRepository());
  locator.registerLazySingleton(() => ApiRepository());
  //*Factory classes
}
