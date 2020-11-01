import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import '../actions.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final Widget _avatar = ClipRRect(
    borderRadius: BorderRadius.circular(65.0),
    child: Image.asset(
      'assets/images/noAvatar.png',
      fit: BoxFit.cover,
      width: 110,
      height: 110,
    ),
  );
  Future<ParseResponse> fetchPicture(String id) async {
    final QueryBuilder<ParseObject> queryPost =
        QueryBuilder<ParseObject>(ParseObject('Picture'))
          ..whereEqualTo('userId', id);

    final ParseResponse apiResponse = await queryPost.query();
    return apiResponse;
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<dynamic, Function(dynamic)>(
        // ignore: void_checks
        onInit: (dynamic store) async {
      final ParseResponse res =
          await fetchPicture(store.state.user.id as String);
      return store.dispatch(MyAction(BlablacookActions.UpdatePic, res.results));
    },
        // ignore: always_specify_types
        converter: (store) {
      return (dynamic pic) {
        return store.dispatch(MyAction(BlablacookActions.UpdatePic, pic));
      };
    }, builder: (BuildContext context, dynamic callback) {
      return Container(
        color: Colors.grey[200],
        child: SafeArea(
          child: Scaffold(
              body: Center(
            child: StoreConnector<dynamic, dynamic>(
              // ignore: always_specify_types
              converter: (store) => store.state,
              builder: (BuildContext context, dynamic state) {
                return Container(
                  child: Column(children: <Widget>[
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // ignore: always_specify_types
                        children: [
                          if (state.user.img != null)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(60.0),
                              child: Image.network(
                                state.user.img.url as String,
                                fit: BoxFit.cover,
                                width: 120,
                                height: 120,
                              ),
                            )
                          else
                            _avatar,
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 14.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // ignore: always_specify_types
                                children: [
                                  Text(
                                    state.user.username as String,
                                    style: const TextStyle(
                                      fontFamily: 'Amatic',
                                      fontSize: 40,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5.0),
                                    child: RatingBarIndicator(
                                      rating: state.user.rate as double,
                                      direction: Axis.horizontal,
                                      itemCount: 5,
                                      itemSize: 20.0,
                                      itemPadding: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      itemBuilder: (BuildContext context, _) =>
                                          const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    state.user.bio as String,
                                    maxLines: 3,
                                    style: const TextStyle(
                                        fontFamily: 'LatoLight',
                                        fontSize: 15,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(children: <Widget>[
                          for (dynamic val in state.user.cookType)
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
                    const SizedBox(height: 30),
                    Container(
                      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Plats cuisinés',
                            style: TextStyle(
                                fontSize: 20, fontFamily: 'LatoLight')),
                      ),
                    ),
                    if (state.pics != null && state.pics.data != null)
                      Expanded(
                        child: GridView.count(
                            primary: false,
                            padding: const EdgeInsets.all(10),
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            crossAxisCount: 2,
                            children: <Widget>[
                              for (dynamic val in state.pics.data)
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Image.network(
                                      val.get('img').url as String,
                                      fit: BoxFit.cover,
                                      width: 120,
                                      height: 120,
                                    ),
                                  ),
                                ),
                            ]),
                      )
                    else
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                            "Oups, le/la cuisinier n'a publié aucun plat pour le moment",
                            style: TextStyle(
                                fontFamily: 'LatoLight',
                                fontSize: 16,
                                color: Colors.black)),
                      )
                  ]),
                );
              },
            ),
          )),
        ),
      );
    });
  }
}
