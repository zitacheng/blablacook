import 'dart:developer';

import 'package:blablacook/actions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import '../utils.dart';

class Book extends StatefulWidget {
  @override
  _BookState createState() => _BookState();
}

class _BookState extends State<Book> {
  Future<ParseResponse> fetchBooking() async {
    final dynamic currentUser = await ParseUser.currentUser();
    final QueryBuilder<ParseObject> queryPost =
        QueryBuilder<ParseObject>(ParseObject('Book'))
          ..includeObject(<String>['client', 'cook'])
          ..whereEqualTo('cook', currentUser);
    final ParseResponse apiResponse = await queryPost.query();
    return apiResponse;
  }

  // ignore: avoid_void_async
  void choiceBooking(dynamic data, bool choice) async {
    data.set('accepted', choice);
    final dynamic response = await data.save();
    if (response.success == true) {
      showAlertDialog(context, 'Réussi', 'choix pris en compte');
      setState(() {});
    } else {
      showAlertDialog(context, 'Erreur', 'veuillez réessayer');
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<dynamic, dynamic>(
        // ignore: void_checks
        onInit: (dynamic store) async {
          final ParseResponse res = await fetchBooking();
          return store
              .dispatch(MyAction(BlablacookActions.UpdateBook, res.results));
        },
        converter: (dynamic store) => store.state,
        builder: (BuildContext context, dynamic state) {
          return SafeArea(
            child: Scaffold(
                body: Center(
                    child: Column(children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text('Liste des réservation',
                    style: TextStyle(
                      fontFamily: 'Amatic',
                      fontSize: 40,
                    )),
              ),
              if (state.book != null)
                for (dynamic data in state.book.data)
                  if (data.get('accepted') == null)
                    Slidable(
                      actionPane: const SlidableDrawerActionPane(),
                      actionExtentRatio: 0.25,
                      child: Container(
                        color: Colors.white,
                        child: ListTile(
                          leading: data.get('client').get('img') != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(25.0),
                                  child: Image.network(
                                      data.get('client').get('img').url
                                          as String,
                                      fit: BoxFit.cover,
                                      width: 50,
                                      height: 50),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(25.0),
                                  child: Image.asset(
                                    'assets/images/noAvatar.png',
                                    fit: BoxFit.cover,
                                    width: 50,
                                    height: 50,
                                  ),
                                ),
                          title: Text(
                              data.get('client').get('username') as String),
                          subtitle: Text(DateFormat('yyyy-MM-dd – kk:mm')
                              .format(data.get('cookDate') as DateTime)),
                        ),
                      ),
                      secondaryActions: <Widget>[
                        IconSlideAction(
                          caption: 'Appeler',
                          color: Colors.blueAccent,
                          icon: Icons.phone,
                          onTap: () {
                            if (data.get('client').get('phone') != null)
                              makePhoneCall(
                                  data.get('client').get('phone') as String);
                            else {
                              showAlertDialog(context, 'Erreur',
                                  "Le client n'a pas fournis son numéro de téléphone");
                            }
                          },
                        ),
                        IconSlideAction(
                          caption: 'Accepter',
                          color: Colors.greenAccent,
                          icon: Icons.check,
                          onTap: () {
                            // makePhoneCall('33620296517');
                            // createEmail('test@gmail.com');
                            choiceBooking(data, true);
                          },
                        ),
                        IconSlideAction(
                          caption: 'Refuser',
                          color: Colors.deepOrange,
                          icon: Icons.close,
                          onTap: () {
                            choiceBooking(data, false);
                          },
                        ),
                      ],
                    )
                  else
                    Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: <Widget>[
                            if (data.get('client').get('img') != null)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(25.0),
                                child: Image.network(
                                    data.get('client').get('img').url as String,
                                    fit: BoxFit.cover,
                                    width: 50,
                                    height: 50),
                              )
                            else
                              ClipRRect(
                                borderRadius: BorderRadius.circular(25.0),
                                child: Image.asset(
                                  'assets/images/noAvatar.png',
                                  fit: BoxFit.cover,
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Text>[
                                      Text(data.get('client').get('username')
                                          as String),
                                      Text(DateFormat('yyyy-MM-dd – kk:mm')
                                          .format(data.get('cookDate')
                                              as DateTime)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Text(
                                data.get('accepted') == true
                                    ? 'Réservation accepté'
                                    : 'Réservation refusé',
                                style: TextStyle(
                                  color: data.get('accepted') == true
                                      ? Colors.green
                                      : Colors.red,
                                  fontFamily: 'Amatic',
                                  fontSize: 22,
                                ))
                          ],
                        ),
                      ),
                    ),
            ]))),
          );
        });
  }
}
