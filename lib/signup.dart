import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:blablacook/utils.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:grouped_buttons/grouped_buttons.dart';

import 'cookType.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final List<String> list = null;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  bool _cooker = false;
  File _image;
  bool _loading = false;
  List<String> _selectedType = <String>[];
  static final double _half = typeCook.length / 2;
  final List<String> _typeCookFirst = typeCook.sublist(0, _half.toInt());
  final List<String> _typeCookSec =
      typeCook.sublist(_half.toInt(), typeCook.length);

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

  void _handleTap() {
    setState(() {
      _cooker = !_cooker;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => !Navigator.of(context).userGestureInProgress,
        child: Container(
          child: SafeArea(
            child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  bottomOpacity: 0.0,
                  elevation: 0.0,
                ),
                backgroundColor: Colors.grey[200],
                body: CustomScrollView(slivers: <Widget>[
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return Container(
                          alignment: Alignment.center,
                          color: Colors.teal[100 * (index % 9)],
                          child: Container(
                            margin: const EdgeInsets.only(top: 60.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const Text(
                                  'Inscription',
                                  style: TextStyle(
                                    fontFamily: 'Amatic',
                                    fontSize: 40,
                                  ),
                                ),
                                SizedBox(
                                    height: 20,
                                    width: 100,
                                    child:
                                        Divider(color: Colors.teal.shade100)),
                                GestureDetector(
                                    onTap: () async {
                                      _image = await getImage(2) as File;
                                      setState(() {});
                                    },
                                    child: Container(
                                      child: Center(
                                          child: Container(
                                              child: _image == null
                                                  ? ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              65.0),
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
                                                          shape:
                                                              BoxShape.circle,
                                                          image: DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image: FileImage(
                                                                  _image))),
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
                                          fillColor: Colors.white,
                                          filled: true,
                                          prefixIcon: Icon(Icons.lock),
                                          hintText: 'Mot de passe',
                                          contentPadding:
                                              EdgeInsets.all(20.0))),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap: _handleTap,
                                          child: Text(
                                            'Cuisinier',
                                            style: TextStyle(
                                                fontFamily: 'Amatic',
                                                fontSize: 24,
                                                color: !_cooker
                                                    ? Colors.black
                                                    : Colors.orange,
                                                fontWeight: !_cooker
                                                    ? FontWeight.w400
                                                    : FontWeight.w900),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: _handleTap,
                                          child: Text(
                                            'Client',
                                            style: TextStyle(
                                                fontFamily: 'Amatic',
                                                fontSize: 24,
                                                color: !_cooker
                                                    ? Colors.orange
                                                    : Colors.black,
                                                fontWeight: _cooker
                                                    ? FontWeight.w400
                                                    : FontWeight.w900),
                                          ),
                                        ),
                                      ]),
                                ),
                                if (_cooker)
                                  Column(
                                    children: <Widget>[
                                      const Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(25, 10, 0, 5),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Choisisser au moins une type de cuisines:',
                                            style: TextStyle(
                                              fontFamily: 'LatoLight',
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Expanded(
                                              flex: 5,
                                              child: CheckboxGroup(
                                                  labels: _typeCookSec,
                                                  labelStyle: const TextStyle(),
                                                  onSelected:
                                                      (List<String> checked) {
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
                                                  onSelected:
                                                      (List<String> checked) {
                                                    setState(() {
                                                      _selectedType = checked;
                                                    });
                                                  }),
                                            ),
                                          ]),
                                      const Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(25, 10, 0, 5),
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
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(40.0),
                                                  ),
                                                  borderSide: BorderSide(
                                                      color: Colors.transparent,
                                                      width: 0.0),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(40.0),
                                                  ),
                                                  borderSide: BorderSide(
                                                      color: Colors.transparent,
                                                      width: 0.0),
                                                ),
                                                fillColor: Colors.white,
                                                filled: true,
                                                prefixIcon:
                                                    Icon(Icons.account_circle),
                                                contentPadding:
                                                    EdgeInsets.all(20.0))),
                                      ),
                                    ],
                                  ),
                                const SizedBox(height: 30),
                                ButtonTheme(
                                  minWidth: 180.0,
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                        side: const BorderSide(
                                            color: Colors.transparent)),
                                    onPressed: _loading
                                        ? null
                                        : () async {
                                            _onLoading();
                                            if (checkForm(
                                                context,
                                                usernameController.text,
                                                emailController.text,
                                                passwordController.text,
                                                bioController.text,
                                                _cooker,
                                                _selectedType))
                                              try {
                                                final ParseUser user =
                                                    ParseUser(
                                                        usernameController.text,
                                                        passwordController.text,
                                                        emailController.text);
                                                user.set(
                                                    'type',
                                                    _cooker
                                                        ? 'cook'
                                                        : 'client');
                                                user.set(
                                                    'cookType', _selectedType);
                                                user.set(
                                                    'bio', bioController.text);
                                                user.set('username',
                                                    usernameController.text);
                                                if (_image != null) {
                                                  final ParseResponse
                                                      fileResponse =
                                                      await ParseFile(_image,
                                                              debug: true)
                                                          .save();
                                                  if (fileResponse.success) {
                                                    final ParseFile parseFile =
                                                        fileResponse.result
                                                            as ParseFile;
                                                    user.set('img', parseFile);
                                                  } else {
                                                    _offLoading();
                                                    showAlertDialog(
                                                        context,
                                                        'Erreur',
                                                        "Erreur de sauvegarde d'image");
                                                  }
                                                }
                                                final ParseResponse response =
                                                    await user.signUp();
                                                if (response.success) {
                                                  _offLoading();
                                                  Navigator.of(context).pop();
                                                } else {
                                                  inspect(response);
                                                  showAlertDialog(
                                                      context,
                                                      'Erreur',
                                                      'Email ou mot de passe invalide');
                                                  _offLoading();
                                                }
                                              } catch (e) {
                                                _offLoading();
                                                print(e);
                                              }
                                            else
                                              _offLoading();
                                          },
                                    child: const Text("M'inscrire",
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
                                  ),
                                const SizedBox(height: 60),
                              ],
                            ),
                          ),
                        );
                      },
                      childCount: 1,
                    ),
                  )
                ])),
          ),
        ));
  }
}
