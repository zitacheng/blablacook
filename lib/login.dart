import 'dart:developer';

import 'package:blablacook/signup.dart';
import 'package:blablacook/utils.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'actions.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
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
    return Container(
      color: Colors.black,
      child: SafeArea(
          child: GestureDetector(
        onTap: () {
          final FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
            backgroundColor: Colors.grey[200],
            body: CustomScrollView(slivers: <Widget>[
              SliverList(
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.fromLTRB(0, 40.0, 0, 50.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'assets/images/logo.png',
                          width: 170,
                          height: 170,
                        ),
                        const Text(
                          'BlaBlaCook',
                          style: TextStyle(
                            fontFamily: 'Amatic',
                            fontSize: 40,
                          ),
                        ),
                        SizedBox(
                            height: 20,
                            width: 100,
                            child: Divider(color: Colors.teal.shade100)),
                        Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: TextField(
                              controller: usernameController,
                              decoration: const InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(40.0),
                                  ),
                                  borderSide: BorderSide(
                                      color: Colors.transparent, width: 0.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(40.0),
                                  ),
                                  borderSide: BorderSide(
                                      color: Colors.transparent, width: 0.0),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                prefixIcon: Icon(Icons.account_circle),
                                hintText: "Email / Nom d'utilisateur",
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(40.0),
                                  ),
                                  borderSide: BorderSide(
                                      color: Colors.transparent, width: 0.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(40.0),
                                  ),
                                  borderSide: BorderSide(
                                      color: Colors.transparent, width: 0.0),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                prefixIcon: Icon(Icons.lock),
                                hintText: 'Mot de passe',
                                contentPadding: EdgeInsets.all(20.0),
                              )),
                        ),
                        const SizedBox(height: 30),
                        StoreConnector<dynamic, Function(dynamic)>(
                            converter: (dynamic store) {
                          return (dynamic user) {
                            return store.dispatch(
                                MyAction(BlablacookActions.UpdateUser, user));
                          };
                        }, builder: (BuildContext context, dynamic callback) {
                          return ButtonTheme(
                            minWidth: 180.0,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: const BorderSide(
                                      color: Colors.transparent)),
                              onPressed: _loading
                                  ? null
                                  : () async {
                                      if (usernameController.text.isEmpty ||
                                          passwordController.text.isEmpty) {
                                        showAlertDialog(context, 'Erreur',
                                            "Veuillez fournir votre nom de d'utilisateur ou email et mot de passe");
                                        return;
                                      }
                                      final ConnectivityResult
                                          connectivityResult =
                                          await Connectivity()
                                              .checkConnectivity();
                                      if (connectivityResult !=
                                              ConnectivityResult.mobile &&
                                          connectivityResult !=
                                              ConnectivityResult.wifi) {
                                        showAlertDialog(context, 'Erreur',
                                            'Vérifiez votre connection internet');
                                        return;
                                      }
                                      _onLoading();
                                      final ParseUser user = ParseUser(
                                          usernameController.text,
                                          passwordController.text,
                                          usernameController.text);
                                      final ParseResponse response =
                                          await user.login();
                                      inspect(response);
                                      inspect(response.error);
                                      if (response.success) {
                                        callback(response.result);
                                        if (response.result.get('type') ==
                                            'cook') {
                                          Navigator.of(context)
                                              .pushNamed('/cook');
                                        }
                                        //  else {
                                        //   Navigator.of(context)
                                        //       .pushNamed('/clientHome');
                                        // }
                                        _offLoading();
                                      } else {
                                        showAlertDialog(context, 'Erreur',
                                            'Email ou mot de passe invalide');
                                        _offLoading();
                                      }
                                    },
                              child: const Text('Me connecter',
                                  style: TextStyle(fontSize: 20)),
                              color: Colors.orange,
                              textColor: Colors.white,
                            ),
                          );
                        }),
                        const SizedBox(height: 5),
                        const Text('Ou'),
                        const SizedBox(height: 5),
                        ButtonTheme(
                          minWidth: 180.0,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: const BorderSide(
                                    color: Colors.transparent)),
                            onPressed: () {
                              Navigator.push<MaterialPageRoute<dynamic>>(
                                context,
                                MaterialPageRoute<MaterialPageRoute<dynamic>>(
                                    builder: (BuildContext context) =>
                                        Signup()),
                              );
                            },
                            child: const Text("S'inscrire",
                                style: TextStyle(fontSize: 20)),
                            color: Colors.orange,
                            textColor: Colors.white,
                          ),
                        ),
                        if (_loading)
                          LoadingBumpingLine.circle(
                            size: 30,
                            backgroundColor: Colors.orange,
                            duration: const Duration(milliseconds: 500),
                          )
                      ],
                    ),
                  );
                }, childCount: 1),
              )
            ])),
      )),
    );
  }
}
