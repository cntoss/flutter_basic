// Package imports:
import 'package:dio/dio.dart' show Response;
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import '../../../repository/api_string.dart';
import '../../common/app_constant.dart';
import '../../service/locator.dart';

class LoginRepository {
  final _api = locator<ApiRepository>();
  final _envBloc = locator<EnvironmentBloc>();
  final _envModel = locator<EnvironmentModel>();

  final AuthUrls _urls = AuthUrls();

  Future saveData(EnvironmentModel _model) async {
    _envModel.token = _model.token;
    _envModel.username = _model.username;
    _envModel.name = _model.name;
    _envModel.email = _model.email;
    _envModel.phoneNumber = _model.phoneNumber;
    _envModel.profileImage = _model.profileImage;

    SharedPreferences _sharedPref = await SharedPreferences.getInstance();
    await _sharedPref.clear();
    _sharedPref.setString(
      tokenKey,
      _model.token!,
    );
    _sharedPref.setString(
      usernameKey,
      _model.username!,
    );
    _sharedPref.setString(
      nameKey,
      _model.name!,
    );
    _sharedPref.setString(
      emailKey,
      _model.email!,
    );
    if (_model.phoneNumber != null) {
      _sharedPref.setString(
        phoneNumberKey,
        _model.phoneNumber!,
      );
    }
    if (_model.profileImage != null) {
      _sharedPref.setString(
        profileImageKey,
        _model.profileImage!,
      );
    }

    _envBloc.setValues();
  }

  login(Map<String, dynamic> body) async {
    try {
      final Response response = await _api.postRequest(
        url: _urls.login,
        body: body,
      );
      final EnvironmentModel _user =
          EnvironmentModel.fromJson(response.data["data"]);
      await saveData(_user);
      return "Welcome ${_user.name}.";
    } catch (e) {
      rethrow;
    }
  }
}
