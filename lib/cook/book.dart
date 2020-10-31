import 'package:blablacook/actions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class Book extends StatefulWidget {
  @override
  _BookState createState() => _BookState();
}

class _BookState extends State<Book> {
  Future<ParseResponse> fetchPicture(dynamic user) async {
    final QueryBuilder<ParseObject> queryPost =
        QueryBuilder<ParseObject>(ParseObject('Book'))
          ..whereEqualTo('cook', user);

    final ParseResponse apiResponse = await queryPost.query();
    return apiResponse;
  }

  // ignore: always_specify_types
  @override
  Widget build(BuildContext context) {
    return StoreConnector<dynamic, Function(dynamic)>(onInit: (store) async {
      final ParseResponse res =
          await fetchPicture(store.state.user.id as String);
      return store.dispatch(MyAction(BlablacookActions.UpdatePic, res.results));
    },
        // ignore: always_specify_types
        converter: (store) {
      // Return a `VoidCallback`, which is a fancy name for a function
      // with no parameters. It only dispatches an Increment action.
      return (dynamic book) {
        return store.dispatch(MyAction(BlablacookActions.UpdateBook, book));
      };
      // ignore: always_specify_types
    }, builder: (BuildContext context, callback) {
      return SafeArea(
        child: Scaffold(
            body: Center(
                child: StoreConnector<dynamic, dynamic>(
          // ignore: always_specify_types
          converter: (store) => store.state,
          builder: (BuildContext context, dynamic state) {
            return Column(children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text('Liste des réservation',
                    style: TextStyle(
                      fontFamily: 'Amatic',
                      fontSize: 40,
                    )),
              ),
              Slidable(
                actionPane: const SlidableDrawerActionPane(),
                actionExtentRatio: 0.25,
                child: Container(
                  color: Colors.white,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.deepOrangeAccent,
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: 170,
                        height: 170,
                      ),
                      foregroundColor: Colors.white,
                    ),
                    title: const Text('Nom du client'),
                    subtitle: const Text('date de réservation'),
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
            ]);
          },
        ))),
      );
    });
  }
}

// ignore: camel_case_types
class _showSnackBar {}
