import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:blablacook/utils.dart';
import 'package:image_picker/image_picker.dart';
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
  final ImagePicker picker = ImagePicker();
  bool _cooker = false;
  File _image;
  bool _loading = false;
  // ignore: always_specify_types
  List<String> _selectedType = [];
  static final double _half = typeCook.length / 2;
  final List<String> _typeCookFirst = typeCook.sublist(0, _half.toInt());
  final List<String> _typeCookSec =
      typeCook.sublist(_half.toInt(), typeCook.length);

  // ignore: always_specify_types
  Future getImage() async {
    final PickedFile pickedFile =
        await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

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
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.grey[200],
          body: Stack(children: <Widget>[
            Container(
                child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: 30.0,
                ),
              ),
            )),
            CustomScrollView(slivers: <Widget>[
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
                            Image.asset(
                              'assets/images/logo.png',
                              width: 120,
                              height: 120,
                            ),
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
                                child: Divider(color: Colors.teal.shade100)),
                            GestureDetector(
                                onTap: () async {
                                  await getImage();
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
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: FileImage(
                                                              _image))),
                                                ))),
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
                                      contentPadding: EdgeInsets.all(20.0))),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  // ignore: always_specify_types
                                  children: [
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
                                // ignore: always_specify_types
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.fromLTRB(25, 10, 0, 5),
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
                                      // ignore: always_specify_types
                                      children: [
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
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: const BorderSide(
                                        color: Colors.transparent)),
                                onPressed: _loading
                                    ? null
                                    : () async {
                                        _onLoading();
                                        try {
                                          final ParseUser user = ParseUser(
                                              emailController.text,
                                              passwordController.text,
                                              emailController.text);
                                          user.set('type',
                                              _cooker ? 'cook' : 'client');
                                          user.set('cookType', _selectedType);
                                          user.set('bio', bioController.text);
                                          if (_image != null) {
                                            final ParseFileBase parseFile =
                                                ParseFile(File(_image.path));

                                            user.set('img', parseFile);
                                          }
                                          final ParseResponse response =
                                              await user.signUp();
                                          if (response.success) {
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
            ]),
          ])),
    );
  }
}
