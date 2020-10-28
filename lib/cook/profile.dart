import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: StoreConnector<dynamic, dynamic>(
      // ignore: always_specify_types
      converter: (store) => store.state.user,
      builder: (BuildContext context, dynamic user) {
        return SafeArea(
          child: Column(
            children: <Widget>[
              Text(user.email as String),
              Text(user.type as String),
            ],
          ),
        );
      },
    )));
  }
}
