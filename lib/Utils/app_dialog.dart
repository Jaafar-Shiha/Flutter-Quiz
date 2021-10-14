import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class AppDialog{

  static void customFlushBar({required BuildContext context, required String message }) {
    Flushbar(
      backgroundGradient: LinearGradient(
        colors: [ Theme.of(context).primaryColor, Theme.of(context).accentColor],
        begin: const FractionalOffset(0, 0),
        end: const FractionalOffset(1.0, 0.0),
        stops: [0.0, 1.0],
        tileMode: TileMode.clamp,

      ),
      message: message,
      duration: Duration(seconds: 3),
    ).show(context);
  }
}
