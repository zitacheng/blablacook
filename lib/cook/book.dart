import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class Book extends StatefulWidget {
  @override
  _BookState createState() => _BookState();
}

class _BookState extends State<Book> {
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
            children: const <Widget>[
              Text('book page'),
            ],
          ),
        );
      },
    )));
  }
}
