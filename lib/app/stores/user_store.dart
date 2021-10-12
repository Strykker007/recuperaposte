import 'package:flutter_triple/flutter_triple.dart';
import 'package:recuperaposte/app/core/models/user_model.dart';

class UserStore extends NotifierStore<Exception, UserModel> {
  UserStore() : super(UserModel(isAdmin: false));
}
