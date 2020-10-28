import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:blablacook/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animations/loading_animations.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final List<String> list = null;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final picker = ImagePicker();
  bool _cooker = false;
  File _image;
  bool _loading = false;

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

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
              child: Padding(
                padding: const EdgeInsets.all(16.0),
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
                                                  decoration: new BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image:
                                                          new DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image: FileImage(
                                                                  _image))),
                                                ))),
                                )),
                            Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: TextField(
                                  controller: emailController,
                                  decoration: const InputDecoration(
                                    enabledBorder: const OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(40.0),
                                      ),
                                      borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 0.0),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(40.0),
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
                                      enabledBorder: const OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(40.0),
                                        ),
                                        borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 0.0),
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(40.0),
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
                                    children: [
                                      GestureDetector(
                                        onTap: _handleTap,
                                        child: Text(
                                          "Cuisinier",
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
                                          "Client",
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
                                    ])),
                            const SizedBox(height: 30),
                            ButtonTheme(
                              minWidth: 180.0,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side:
                                        BorderSide(color: Colors.transparent)),
                                onPressed: _loading
                                    ? null
                                    : () async {
                                        _onLoading();
                                        try {
                                          final user = ParseUser(
                                              emailController.text,
                                              passwordController.text,
                                              emailController.text);
                                          user.set('type',
                                              _cooker ? 'cook' : 'client');
                                          if (_image != null) {
                                            ParseFileBase parseFile =
                                                ParseFile(File(_image.path));

                                            user.set('img', parseFile);
                                          }

                                          var response = await user.signUp();
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
                            _loading
                                ? LoadingBumpingLine.circle(
                                    size: 30,
                                    backgroundColor: Colors.orange,
                                    duration: Duration(milliseconds: 500),
                                  )
                                : const SizedBox(height: 0)
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
