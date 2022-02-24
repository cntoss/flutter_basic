// Dart imports:
import 'dart:async';

// Package imports:
import 'package:rxdart/rxdart.dart' show BehaviorSubject, Rx;

// Project imports:
import '../../../repository/api_exception.dart';
import '../../service/locator.dart';
import '../model/login_model.dart';

class LoginBloc {
  final _loginApi = locator<
      LoginRepository>(); //* Carries out all the API functions for Login module
  //*StreamControllers for Login Module
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _phoneNo = BehaviorSubject<String>();
  //*StreamControllers for Login Module

  //validation
  final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(email) &&
        email != "") {
      sink.add(email);
    } else {
      sink.addError('Please enter a valid email address.');
    }
  });
  //*Getter for Streams
  Stream<String> get email => _email.stream.transform(validateEmail);
  Stream<String> get password =>
      _password.stream.transform(StreamTransformer<String, String>.fromHandlers(
          handleData: (password, sink) {
        sink.add(password);
      }));

  //*Value accessors
  String get emailValue => _email.value;
  String get phoneValue => _phoneNo.value;
  //*Value accessors

  //*Rx combining for validation of buttons
  Stream<bool> get loginValid => Rx.combineLatest2(
      email, password, (e, p) => true); //Validates the login button
  Stream<bool> get emailValid => email.map((email) =>
      true); //Determines if the button should be enabled as per data entered by the user
  //*Rx combining for validation of buttons

  //*Data modifiers/setters
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;

  //*Data modifiers/setters

  //* Login to the server and fetch the auth token.
  login() async {
    LoginModel _model;

    if (true) {
      _model = LoginModel(
          email: _email.valueOrNull, password: _password.valueOrNull);
    }
    try {
      final _response = await _loginApi.login(_model.toJson());
      clear();
      return (_response);
    } on AppApiException catch (e) {
      throw e.message ?? 'Server error';
    } catch (e) {
      throw e.toString();
    }
  }

  clear() {
    _password.sink.add("");
  }

  closeStream() {
    _email.close();
    _phoneNo.close();
    _password.close();
  }
}
