import 'package:flutter/material.dart';

dynamic showAlertDialog(BuildContext context, String title, String message) {
  // set up the button
  final Widget okButton = FlatButton(
    child: const Text('OK'),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  final AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(message),
    // ignore: always_specify_types
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog<AlertDialog>(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
