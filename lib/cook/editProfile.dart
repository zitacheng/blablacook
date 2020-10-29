import 'dart:io';
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
  final bool _cooker = true;
  final bool _tapped = false;
  File _image;
  bool _loading = false;
  // ignore: always_specify_types
  List<String> _selectedType = [];
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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          const BoxShadow(color: Colors.white, spreadRadius: 3),
        ],
      ),
      child: StoreConnector<dynamic, dynamic>(
          // ignore: always_specify_types
          converter: (store) => store.state.user,
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
                    _image = await getImage() as File;
                    setState(() {
                      _loading = true;
                    });
                  },
                  child: Container(
                    child: Center(
                        child: Container(
                            child: _image == null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(65.0),
                                    child: Image.asset(
                                      'assets/images/noAvatar.png',
                                      fit: BoxFit.cover,
                                      width: 110,
                                      height: 110,
                                    ),
                                  )
                                : Container(
                                    width: 110.0,
                                    height: 110.0,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: FileImage(_image))),
                                  ))),
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
                    obscureText: true,
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
                        prefixIcon: Icon(Icons.lock),
                        hintText: 'Mot de passe',
                        contentPadding: EdgeInsets.all(20.0))),
              ),
              if (_cooker)
                Column(
                  // ignore: always_specify_types
                  children: [
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
                        // ignore: always_specify_types
                        children: [
                          Expanded(
                            flex: 5,
                            child: CheckboxGroup(
                                labels: _typeCookSec,
                                labelStyle: const TextStyle(),
                                onSelected: (List<String> checked) {
                                  setState(() {
                                    _selectedType = checked;
                                  });
                                }),
                          ),
                          Expanded(
                            flex: 5,
                            child: CheckboxGroup(
                                labels: _typeCookFirst,
                                labelStyle: const TextStyle(),
                                onSelected: (List<String> checked) {
                                  setState(() {
                                    _selectedType = checked;
                                  });
                                }),
                          ),
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
                      child: TextField(
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
              Padding(
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
                            try {
                              final dynamic user =
                                  await ParseUser.currentUser();
                              user.set('type', _cooker ? 'cook' : 'client');
                              user.set('cookType', _selectedType);
                              user.set('bio', bioController.text);
                              user.set('username', usernameController.text);
                              if (_image != null && _tapped) {
                                final ParseResponse fileResponse =
                                    await ParseFile(_image, debug: true).save();
                                if (fileResponse.success) {
                                  final ParseFile parseFile =
                                      fileResponse.result as ParseFile;
                                  user.set('img', parseFile);
                                } else {
                                  _offLoading();
                                  showAlertDialog(context, 'Erreur',
                                      "Erreur de sauvegarde d'image");
                                }
                              }
                              final dynamic response = await user.save();
                              if (response.success == true) {
                                _offLoading();
                                Navigator.of(context).pop();
                              } else {
                                showAlertDialog(context, 'Erreur',
                                    'Email ou mot de passe invalide');
                                _offLoading();
                              }
                            } catch (e) {
                              _offLoading();
                              print(e);
                            }
                          },
                    child: const Text('Sauvegarder',
                        style: TextStyle(fontSize: 20)),
                    color: Colors.orange,
                    textColor: Colors.white,
                  ),
                ),
              ),
              if (_loading)
                LoadingBumpingLine.circle(
                  size: 30,
                  backgroundColor: Colors.orange,
                  duration: const Duration(milliseconds: 500),
                ),
              const SizedBox(height: 60),
            ]));
          }),
    );
  }
}
