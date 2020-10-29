import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: StoreConnector<dynamic, dynamic>(
          // ignore: always_specify_types
          converter: (store) => store.state.user,
          builder: (BuildContext context, dynamic user) {
            return SafeArea(
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 30),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(60.0),
                    child: Image.network(
                      user.img.url as String,
                      fit: BoxFit.cover,
                      width: 120,
                      height: 120,
                    ),
                  ),
                  Text(
                    user.username as String,
                    style: const TextStyle(
                      fontFamily: 'Amatic',
                      fontSize: 40,
                    ),
                  ),
                  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(children: <Widget>[
                        for (dynamic val in user.cookType)
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Chip(
                              padding: const EdgeInsets.all(0),
                              backgroundColor: Colors.orangeAccent,
                              label: Text(val as String,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontFamily: 'LatoLight')),
                            ),
                          ),
                      ])),
                  Text(user.email as String),
                  Text(user.type as String),
                  Text(user.bio != null ? user.bio as String : 'Pas de bio'),
                ],
              ),
            );
          },
        ),
      ),
    ));
  }
}
