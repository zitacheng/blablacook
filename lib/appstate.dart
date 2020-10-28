import 'package:meta/meta.dart';

class User {
  String email = '';
  String type = '';
  // ignore: sort_constructors_first
  User(this.email, this.type);
}

@immutable
class AppState {
  final User user;

  // ignore: sort_constructors_first
  const AppState({this.user});
}
