import 'package:blablacook/signup.dart';
import 'package:blablacook/utils.dart';
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
          child: Scaffold(
              backgroundColor: Colors.grey[200],
              body: CustomScrollView(slivers: <Widget>[
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return Container(
                      alignment: Alignment.center,
                      color: Colors.teal[100 * (index % 9)],
                      child: Container(
                        margin: const EdgeInsets.only(top: 80.0),
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
                                          color: Colors.transparent,
                                          width: 0.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(40.0),
                                      ),
                                      borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 0.0),
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
                                          color: Colors.transparent,
                                          width: 0.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(40.0),
                                      ),
                                      borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 0.0),
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
                                // ignore: always_specify_types
                                converter: (store) {
                              // Return a `VoidCallback`, which is a fancy name for a function
                              // with no parameters. It only dispatches an Increment action.
                              return (dynamic user) {
                                return store.dispatch(MyAction(
                                    BlablacookActions.UpdateUser, user));
                              };
                              // ignore: always_specify_types
                            }, builder: (BuildContext context, callback) {
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
                                          _onLoading();
                                          try {
                                            final ParseUser user = ParseUser(
                                                usernameController.text,
                                                passwordController.text,
                                                usernameController.text);
                                            final ParseResponse response =
                                                await user.login();
                                            if (response.success) {
                                              callback(response.result);
                                              if (response.result.get('type') ==
                                                  'cook') {
                                                Navigator.of(context)
                                                    .pushNamed('/cookOffer');
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
                                          } catch (e) {
                                            print(e);
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
                                    MaterialPageRoute<
                                            MaterialPageRoute<dynamic>>(
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
                      ),
                    );
                  }, childCount: 1),
                )
              ]))),
    );
  }
}
