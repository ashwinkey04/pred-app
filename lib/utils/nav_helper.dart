import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future nativePush(BuildContext context, Widget page) {
  return Platform.isIOS
      ? Future.delayed(Duration.zero, () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => page,
            ),
          );
        })
      : Future.delayed(Duration.zero, () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => page,
            ),
          );
        });
}

nativePushReplacement(BuildContext context, Widget page) {
  return Platform.isIOS
      ? Future.delayed(Duration.zero, () {
          Navigator.pushReplacement(
            context,
            CupertinoPageRoute(
              builder: (context) => page,
            ),
          );
        })
      : Future.delayed(Duration.zero, () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => page,
            ),
          );
        });
}

nativePushUntil(BuildContext context, Widget page) {
  Navigator.pushAndRemoveUntil(
      context,
      Platform.isIOS
          ? CupertinoPageRoute(
              builder: (context) => page,
            )
          : MaterialPageRoute(
              builder: (context) => page,
            ),
      (route) => false);
}
