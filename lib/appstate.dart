import 'package:meta/meta.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class User {
  String email = '';
  String type = '';
  String bio = '';
  String username = '';
  String id = '';
  // ignore: avoid_init_to_null
  List<dynamic> cookType = null;
  // ignore: avoid_init_to_null
  ParseFile img = null;
  // ignore: sort_constructors_first
  User(this.email, this.type, this.bio, this.cookType, this.img, this.username,
      this.id);
}

class Picture {
  // ignore: avoid_init_to_null
  List<ParseObject> data = null;

  // ignore: sort_constructors_first
  Picture(this.data);
}

@immutable
class AppState {
  final User user;
  final Picture pics;

  // ignore: sort_constructors_first
  const AppState({this.user, this.pics});
}
