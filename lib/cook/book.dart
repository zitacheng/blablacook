import 'package:blablacook/actions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

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
          ..whereEqualTo('cook', currentUser)
          ..whereEqualTo('accepted', null);
    final ParseResponse apiResponse = await queryPost.query();
    return apiResponse;
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
              for (dynamic data in state.book.data)
                Slidable(
                  actionPane: const SlidableDrawerActionPane(),
                  actionExtentRatio: 0.25,
                  child: Container(
                    color: Colors.white,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.deepOrangeAccent,
                        child: state.user.img != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(60.0),
                                child: Image.network(
                                  state.user.img.url as String,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Image.asset(
                                'assets/images/logo.png',
                                width: 170,
                                height: 170,
                              ),
                        foregroundColor: Colors.white,
                      ),
                      title: Text(data.get('client').get('username') as String),
                      subtitle: Text(DateFormat('yyyy-MM-dd – kk:mm')
                          .format(data.get('cookDate') as DateTime)),
                    ),
                  ),
                  secondaryActions: <Widget>[
                    IconSlideAction(
                      caption: 'Accepter',
                      color: Colors.greenAccent,
                      icon: Icons.check,
                      onTap: () => _showSnackBar(),
                    ),
                    IconSlideAction(
                      caption: 'Refuser',
                      color: Colors.deepOrange,
                      icon: Icons.close,
                      onTap: () => _showSnackBar(),
                    ),
                  ],
                ),
            ]))),
          );
        });
  }
}

// ignore: camel_case_types
class _showSnackBar {}
