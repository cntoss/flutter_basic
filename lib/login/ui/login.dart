// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../../../repository/api_exception.dart';
import '../../service/locator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  bool _showPassword = false;
  final LoginRepository _loginRepository = locator<LoginRepository>();
  final UiHelper _uiHelper = locator<UiHelper>();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  _signIn(String phone, pass) async {
    Map<String, dynamic> data = {
      'phoneNumber': phone,
      'password': pass,
    };
    try {
      var message = await _loginRepository.login(data);
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
      _uiHelper.showToast(msg: message);
    } on AppApiException catch (e) {
      setState(() {
        _isLoading = false;
      });
      _uiHelper.showToast(msg: e.message ?? 'Server Error');
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _uiHelper.showToast(msg: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: InkWell(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.pink, Colors.purple],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
          child: _isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                  color: Colors.white,
                ))
              : ListView(
                  children: <Widget>[
                    headerSection(),
                    textSection(),
                    _buttons()
                  ],
                ),
        ),
      ),
    );
  }

  Container headerSection() {
    return Container(
      margin: const EdgeInsets.only(top: 50.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      child: const Text("Welcome to UG Bazaar",
          style: TextStyle(
              color: Colors.white70,
              fontSize: 40.0,
              fontWeight: FontWeight.bold)),
    );
  }

  Container textSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Column(
        children: <Widget>[
          TextField(
            keyboardType: TextInputType.phone,
            controller: phoneController,
            cursorColor: Colors.white,
            style: const TextStyle(color: Colors.white70),
            decoration: const InputDecoration(
              icon: Icon(Icons.phone_android, color: Colors.white70),
              hintText: "Phone Number",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
          const SizedBox(height: 30.0),
          TextField(
            controller: passwordController,
            cursorColor: Colors.white,
            obscureText: !_showPassword,
            keyboardType: TextInputType.text,
            style: const TextStyle(color: Colors.white70),
            decoration: InputDecoration(
              icon: const Icon(Icons.lock, color: Colors.white70),
              hintText: "Password",
              border: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              hintStyle: const TextStyle(color: Colors.white70),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _showPassword = !_showPassword;
                  });
                },
                child: Icon(
                  _showPassword ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white70,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _buttons() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 16,
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        margin: const EdgeInsets.only(top: 15.0),
        child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: const BorderSide(color: Colors.pinkAccent))),
            backgroundColor: MaterialStateProperty.all(Colors.pink),
          ),
          onPressed: () async {
            if (phoneController.text != "" || passwordController.text != "") {
              setState(() {
                _isLoading = true;
              });
              _uiHelper.hideKeyboard(context);
              _signIn(
                phoneController.text,
                passwordController.text,
              );
            }
          },
          child: const Text("Login", style: TextStyle(color: Colors.white70)),
        ),
      ),
    );
  }
}
