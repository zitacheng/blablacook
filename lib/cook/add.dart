import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import '../utils.dart';

enum WhyFarther { harder, smarter, selfStarter, tradingCharter }

class Add extends StatefulWidget {
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  File _image;
  bool _loading = false;
  final TextEditingController aboutController = TextEditingController();

  Future<ParseResponse> uploadPicture(
      String id, String name, ParseFile parseFile) async {
    final ParseObject query = ParseObject('Picture')
      ..set('name', name)
      ..set('img', parseFile)
      ..set('userId', id);
    final ParseResponse apiResponse = await query.save();
    _offLoading();

    return apiResponse;
  }

  void _onLoading() {
    setState(() {
      _loading = true;
    });
  }

  void _offLoading() {
    _image = null;
    aboutController.text = '';
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.grey[200],
            body: Center(
                child: StoreConnector<dynamic, dynamic>(
              converter: (dynamic store) => store.state.user,
              builder: (BuildContext context, dynamic user) {
                return CustomScrollView(slivers: <Widget>[
                  SliverList(
                      delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                    return Container(
                      margin: const EdgeInsets.only(top: 90.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            'Ajouter une photo de plat',
                            style: TextStyle(
                              fontFamily: 'Amatic',
                              fontSize: 40,
                            ),
                          ),
                          SizedBox(
                              height: 20,
                              width: 100,
                              child: Divider(color: Colors.teal.shade100)),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                const Text(
                                  'Choisissez une image:',
                                  style: TextStyle(
                                    fontFamily: 'LatoLight',
                                    fontSize: 18,
                                  ),
                                ),
                                PopupMenuButton<int>(
                                  icon: const Icon(Icons.file_upload),
                                  onSelected: (int idx) async {
                                    _image = await getImage(idx) as File;
                                    setState(() {});
                                  },
                                  itemBuilder: (BuildContext context) =>
                                      <PopupMenuItem<int>>[
                                    const PopupMenuItem<int>(
                                      value: 1,
                                      child: Text(
                                        'Prendre une photo',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    const PopupMenuItem<int>(
                                      value: 2,
                                      child: Text(
                                        'Choisir dans la librairie',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ],
                                  elevation: 4,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 50),
                                )
                              ],
                            ),
                          ),
                          if (_image == null)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Image.asset(
                                'assets/images/plate.png',
                                fit: BoxFit.cover,
                                width: 150,
                                height: 150,
                              ),
                            )
                          else
                            Container(
                              width: 150.0,
                              height: 150.0,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(20.0),
                                  ),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(_image))),
                            ),
                          Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(20.0, 40, 20.0, 0),
                              child: TextField(
                                controller: aboutController,
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
                                  prefixIcon: Icon(Icons.info),
                                  hintText: 'Nom du plat',
                                ),
                              )),
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: ButtonTheme(
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
                                        if (_image != null) {
                                          final ParseResponse fileResponse =
                                              await ParseFile(_image,
                                                      debug: true)
                                                  .save();
                                          if (fileResponse.success) {
                                            final ParseFile parseFile =
                                                fileResponse.result
                                                    as ParseFile;
                                            uploadPicture(
                                                user.id as String,
                                                aboutController.text,
                                                parseFile);
                                          } else {
                                            _offLoading();
                                            showAlertDialog(context, 'Erreur',
                                                "Erreur de sauvegarde d'image");
                                          }
                                        } else {
                                          _offLoading();
                                          showAlertDialog(context, 'Erreur',
                                              'Veuillez choisir une image');
                                        }
                                      },
                                child: const Text('Ajouter',
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
                        ],
                      ),
                    );
                  }, childCount: 1))
                ]);
              },
            ))),
      ),
    );
  }
}
