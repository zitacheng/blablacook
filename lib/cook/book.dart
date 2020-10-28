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
      converter: (store) => store.state.user,
      builder: (context, dynamic user) {
        return SafeArea(
          child: Column(
            children: <Widget>[
              Text('book page'),
            ],
          ),
        );
      },
    )));
  }
}
