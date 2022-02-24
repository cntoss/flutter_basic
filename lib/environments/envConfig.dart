// Package imports:
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import '../common/app_constant.dart';
import '../service/locator.dart';

class EnvConfig {
  static Future<void> initialize() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    //Registering the EnvironmentModel to the App.
    locator.registerLazySingleton(() => EnvironmentModel(
          uuid: sharedPreferences.getString(uuidKey),
          name: sharedPreferences.getString(nameKey),
          username: sharedPreferences.getString(usernameKey),
          profileImage: sharedPreferences.getString(profileImageKey),
          email: sharedPreferences.getString(emailKey),
          phoneNumber: sharedPreferences.getString(phoneNumberKey),
          token: sharedPreferences.getString(tokenKey),
        ));
  }
}
