import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class Add extends StatefulWidget {
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: StoreConnector<dynamic, dynamic>(
      converter: (store) => store.state.user,
      builder: (context, dynamic user) {
        return SafeArea(
          child: Column(
            children: <Widget>[
              Text('add page'),
            ],
          ),
        );
      },
    )));
  }
}
