import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

enum WhyFarther { harder, smarter, selfStarter, tradingCharter }

class Add extends StatefulWidget {
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.grey[200],
            body: Center(
                child: StoreConnector<dynamic, dynamic>(
              // ignore: always_specify_types
              converter: (store) => store.state.user,
              builder: (BuildContext context, dynamic user) {
                return SafeArea(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Image.asset(
                          'assets/images/logo.png',
                          width: 170,
                          height: 170,
                        ),
                      ),
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
                              onSelected: (int idx) {
                                print(idx);
                              },
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuItem<int>>[
                                const PopupMenuItem<int>(
                                  value: 1,
                                  child: Text(
                                    'Prendre une photo',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                ),
                                const PopupMenuItem<int>(
                                  value: 2,
                                  child: Text(
                                    'Choisir dans la librairie',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ],
                              elevation: 4,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 50),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ))),
      ),
    );
  }
}
