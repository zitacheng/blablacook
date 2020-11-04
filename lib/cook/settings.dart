import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import '../utils.dart';
import 'editProfile.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _loading = false;

  void _onLoading() {
    setState(() {
      _loading = true;
    });
  }

  void _offLoading() {
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: StoreConnector<dynamic, dynamic>(
      converter: (dynamic store) => store.state.user,
      builder: (BuildContext context, dynamic user) {
        return SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
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
              SizedBox(
                  height: 20,
                  width: 100,
                  child: Divider(color: Colors.teal.shade100)),
              ButtonTheme(
                minWidth: 180.0,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: const BorderSide(color: Colors.transparent)),
                  onPressed: () {
                    showModalBottomSheet<Container>(
                        backgroundColor: Colors.transparent,
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return FractionallySizedBox(
                            heightFactor: 0.9,
                            child: EditProfile(),
                          );
                        });
                  },
                  child: const Text('Modifier le profil',
                      style: TextStyle(fontSize: 20)),
                  color: Colors.orange,
                  textColor: Colors.white,
                ),
              ),
              ButtonTheme(
                minWidth: 180.0,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: const BorderSide(color: Colors.transparent)),
                  onPressed: _loading
                      ? null
                      : () async {
                          _onLoading();
                          final dynamic currentUser =
                              await ParseUser.currentUser();
                          final dynamic res = await currentUser.logout();
                          if (res.success == true) {
                            Navigator.of(context).pushNamed('/');
                          } else {
                            showAlertDialog(
                                context, 'Erreur', 'Erreur de déconnexion');
                          }
                          _offLoading();
                        },
                  child:
                      const Text('Déconnexion', style: TextStyle(fontSize: 20)),
                  color: Colors.orange,
                  textColor: Colors.white,
                ),
              ),
              if (_loading)
                LoadingBumpingLine.circle(
                  size: 30,
                  backgroundColor: Colors.orange,
                  duration: const Duration(milliseconds: 500),
                ),
              const SizedBox(height: 60),
            ],
          ),
        );
      },
    )));
  }
}
