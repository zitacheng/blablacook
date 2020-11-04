import 'dart:developer';
import 'dart:io';
import 'package:blablacook/actions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import '../cookType.dart';
import '../utils.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final List<String> list = null;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  bool _tapped = false;
  File _image;
  bool _loading = false;
  Widget _avatar = ClipRRect(
    borderRadius: BorderRadius.circular(65.0),
    child: Image.asset(
      'assets/images/noAvatar.png',
      fit: BoxFit.cover,
      width: 110,
      height: 110,
    ),
  );
  // ignore: always_specify_types
  final List<String> _selectedType = [];
  final List<String> _typeCookFirst = typeCook.sublist(0, typeCook.length ~/ 2);
  final List<String> _typeCookSec =
      typeCook.sublist(typeCook.length ~/ 2, typeCook.length);

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

  void initTextFielf(dynamic user) {
    usernameController.text = user.username as String;
    usernameController.selection = TextSelection.fromPosition(
        TextPosition(offset: usernameController.text.length));

    emailController.text = user.email as String;
    emailController.selection = TextSelection.fromPosition(
        TextPosition(offset: emailController.text.length));
    passwordController.text = user.email as String;
    passwordController.selection = TextSelection.fromPosition(
        TextPosition(offset: passwordController.text.length));

    bioController.text = user.bio as String;
    bioController.selection = TextSelection.fromPosition(
        TextPosition(offset: bioController.text.length));

    for (dynamic i = 0; i < user.cookType.length == true; i++) {
      _selectedType.add(user.cookType[i] as String);
    }
    inspect(_selectedType);

    if (user.img != null && _image == null)
      _avatar = ClipRRect(
        borderRadius: BorderRadius.circular(60.0),
        child: Image.network(
          user.img.url as String,
          fit: BoxFit.cover,
          width: 120,
          height: 120,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: const <BoxShadow>[
            BoxShadow(color: Colors.white, spreadRadius: 3),
          ],
        ),
        child: StoreConnector<dynamic, dynamic>(
            onInit: (dynamic store) async {
              initTextFielf(store.state.user);
            },
            converter: (dynamic store) => store.state.user,
            builder: (BuildContext context, dynamic user) {
              return Scaffold(
                  body: ListView(children: <Widget>[
                const SizedBox(
                  height: 20,
                  width: 100,
                ),
                const Center(
                  child: Text(
                    'Modifier vos informations',
                    style: TextStyle(
                      fontFamily: 'Amatic',
                      fontSize: 40,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 50.0, left: 50.0),
                  child: SizedBox(
                      height: 20,
                      width: 100,
                      child: Divider(color: Colors.teal.shade100)),
                ),
                GestureDetector(
                    onTap: () async {
                      _image = await getImage(2) as File;
                      setState(() {
                        _avatar = Container(
                          width: 110.0,
                          height: 110.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.cover, image: FileImage(_image))),
                        );
                      });
                    },
                    child: Container(
                      child: Center(child: Container(child: _avatar)),
                    )),
                Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: usernameController,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(40.0),
                          ),
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 0.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(40.0),
                          ),
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 0.0),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        prefixIcon: Icon(Icons.account_box),
                        hintText: "Nom d'utilisateur",
                      ),
                    )),
                Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(40.0),
                          ),
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 0.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(40.0),
                          ),
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 0.0),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        prefixIcon: Icon(Icons.email),
                        hintText: 'Email',
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                      controller: passwordController,
                      onChanged: (String val) {
                        if (_tapped != true)
                          setState(() {
                            _tapped = true;
                          });
                      },
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
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: Icon(Icons.lock),
                          hintText: 'Mot de passe',
                          contentPadding: EdgeInsets.all(20.0))),
                ),
                if (user.type == 'cook')
                  Column(
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.fromLTRB(25, 10, 0, 5),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Sélectionnez au moins une type de cuisines:',
                            style: TextStyle(
                              fontFamily: 'LatoLight',
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              flex: 5,
                              child: CheckboxGroup(
                                  checked: _selectedType,
                                  labels: _typeCookSec,
                                  labelStyle: const TextStyle(),
                                  onChange:
                                      (bool checked, String val, int idx) {
                                    if (checked == true &&
                                        _selectedType.contains(val) != true)
                                      _selectedType.add(val);
                                    else
                                      _selectedType.remove(val);
                                  }),
                            ),
                            Expanded(
                                flex: 5,
                                child: CheckboxGroup(
                                    checked: _selectedType,
                                    labels: _typeCookFirst,
                                    labelStyle: const TextStyle(),
                                    onChange:
                                        (bool checked, String val, int idx) {
                                      if (checked == true &&
                                          _selectedType.contains(val) != true)
                                        _selectedType.add(val);
                                      else
                                        _selectedType.remove(val);
                                    })),
                          ]),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(25, 10, 0, 5),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Bio:',
                            style: TextStyle(
                              fontFamily: 'LatoLight',
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextFormField(
                            controller: bioController,
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
                                fillColor: Colors.white,
                                filled: true,
                                prefixIcon: Icon(Icons.account_circle),
                                contentPadding: EdgeInsets.all(20.0))),
                      ),
                    ],
                  ),
                const SizedBox(height: 30),
                StoreConnector<dynamic, Function(dynamic)>(
                    converter: (dynamic store) {
                  return (dynamic user) {
                    return store
                        .dispatch(MyAction(BlablacookActions.UpdateUser, user));
                  };
                }, builder: (BuildContext context, dynamic callback) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                    child: ButtonTheme(
                      minWidth: 160.0,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: const BorderSide(color: Colors.transparent)),
                        onPressed: _loading
                            ? null
                            : () async {
                                _onLoading();
                                final bool cooker =
                                    // ignore: avoid_bool_literals_in_conditional_expressions
                                    user.type == 'cook' ? true : false;
                                if (checkForm(
                                    context,
                                    usernameController.text,
                                    emailController.text,
                                    passwordController.text,
                                    bioController.text,
                                    cooker,
                                    _selectedType))
                                  try {
                                    final dynamic parseUser =
                                        await ParseUser.currentUser();
                                    parseUser.set('cookType', _selectedType);
                                    parseUser.set('bio', bioController.text);
                                    parseUser.set(
                                        'username', usernameController.text);
                                    if (_tapped == true)
                                      parseUser.set(
                                          'password', passwordController.text);
                                    if (_image != null) {
                                      final ParseResponse fileResponse =
                                          await ParseFile(_image, debug: true)
                                              .save();
                                      if (fileResponse.success) {
                                        final ParseFile parseFile =
                                            fileResponse.result as ParseFile;
                                        parseUser.set('img', parseFile);
                                      } else {
                                        _offLoading();
                                        showAlertDialog(context, 'Erreur',
                                            "Erreur de sauvegarde d'image");
                                      }
                                    }
                                    final dynamic response =
                                        await parseUser.save();
                                    if (response.success == true) {
                                      callback(response.result);
                                      showAlertDialog(context, 'Réussi',
                                          'Sauvegarde prise en compte');
                                      _offLoading();
                                    } else {
                                      showAlertDialog(context, 'Erreur',
                                          'Sauvegarde non prise en compte');
                                      _offLoading();
                                    }
                                  } catch (e) {
                                    _offLoading();
                                    print(e);
                                  }
                                else
                                  _offLoading();
                              },
                        child: const Text('Sauvegarder',
                            style: TextStyle(fontSize: 20)),
                        color: Colors.orange,
                        textColor: Colors.white,
                      ),
                    ),
                  );
                }),
                if (_loading)
                  LoadingBumpingLine.circle(
                    size: 30,
                    backgroundColor: Colors.orange,
                    duration: const Duration(milliseconds: 500),
                  ),
                const SizedBox(height: 60),
              ]));
            }));
  }
}
