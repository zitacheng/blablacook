import 'actions.dart';
import 'appstate.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
    user: _userReducer(state.user, action),
  );
}

User _userReducer(User state, dynamic action) {
  print('in reducer');
  if (action.key == BlablacookActions.UpdateUser) {
    return User(action.value.get('email') as String,
        action.value.get('type') as String);
  }
  return state;
}
