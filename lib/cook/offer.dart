import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class Offer extends StatefulWidget {
  @override
  _OfferState createState() => _OfferState();
}

class _OfferState extends State<Offer> {
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
              Text('offer page'),
            ],
          ),
        );
      },
    )));
  }
}
