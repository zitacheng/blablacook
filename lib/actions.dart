enum BlablacookActions {
  UpdateUser,
  CleareUser,
  UpdatePic,
  ClearPic,
  UpdateBook,
  ClearBook
}

class MyAction {
  BlablacookActions key;
  dynamic value;
  // ignore: sort_constructors_first
  MyAction(this.key, this.value);
}
