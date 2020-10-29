import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import '../utils.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: StoreConnector<dynamic, dynamic>(
      // ignore: always_specify_types
      converter: (store) => store.state.user,
      builder: (BuildContext context, dynamic user) {
        return SafeArea(
          child: Column(
            children: <Widget>[
              // ignore: unnecessary_const
              Image.asset(
                'assets/images/logo.png',
                width: 170,
                height: 170,
              ),
              const Text(
                'Paramètre',
                style: TextStyle(
                  fontFamily: 'Amatic',
                  fontSize: 40,
                ),
              ),
              ButtonTheme(
                minWidth: 180.0,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: const BorderSide(color: Colors.transparent)),
                  onPressed: () async {
                    final dynamic currentUser = await ParseUser.currentUser();
                    final dynamic res = await currentUser.logout();
                    if (res.success == true) {
                      Navigator.of(context).pushNamed('/');
                    } else {
                      showAlertDialog(
                          context, 'Erreur', 'Erreur de déconnexion');
                    }
                  },
                  child:
                      const Text('Déconnexion', style: TextStyle(fontSize: 20)),
                  color: Colors.orange,
                  textColor: Colors.white,
                ),
              )
            ],
          ),
        );
      },
    )));
  }
}
