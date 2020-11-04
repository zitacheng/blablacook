import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'actions.dart';
import 'appstate.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
      user: _userReducer(state.user, action),
      pics: _picsReducer(state.pics, action),
      book: _bookReducer(state.book, action));
}

User _userReducer(User state, dynamic action) {
  if (action.key == BlablacookActions.UpdateUser) {
    return User(
      action.value.get('email') as String,
      action.value.get('type') as String,
      action.value.get('bio') as String,
      action.value.get('cookType') as List<dynamic>,
      action.value.get('img') as ParseFile,
      action.value.get('username') as String,
      action.value.objectId as String,
      action.value.get('rate') as double,
      action.value.get('phone') as String,
    );
  }
  if (action.key == BlablacookActions.CleareUser) {
    return User('', '', '', null, null, '', '', 0, '');
  }
  return state;
}

Picture _picsReducer(Picture state, dynamic action) {
  if (action.key == BlablacookActions.UpdatePic) {
    return Picture(
      action.value as List<ParseObject>,
    );
  }
  if (action.key == BlablacookActions.ClearPic) {
    return Picture(
      null,
    );
  }
  return state;
}

Book _bookReducer(Book state, dynamic action) {
  if (action.key == BlablacookActions.UpdateBook) {
    return Book(
      action.value as List<ParseObject>,
    );
  }
  if (action.key == BlablacookActions.ClearPic) {
    return Book(
      null,
    );
  }
  return state;
}
