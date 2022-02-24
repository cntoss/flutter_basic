// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:shared_preferences/shared_preferences.dart';

class LogoutHelper {
  void loggedOutAert(context) {
    AlertDialog alertDialog = AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0))),
      content: const Text("Are you sure, You want to log out?"),
      actions: <Widget>[
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.pink),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: const BorderSide(color: Colors.pinkAccent)))),
          child: const Text(
            "Yes",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            logOuts(context);
          },
        ),
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: const BorderSide(color: Colors.white70)))),
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.pink),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );

    showDialog(context: context, builder: (_) => alertDialog);
  }

  logOuts(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    Future.delayed(Duration.zero, () {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
    });
  }
}
