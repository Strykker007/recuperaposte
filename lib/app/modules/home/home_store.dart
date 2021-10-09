import 'package:flutter_triple/flutter_triple.dart';
import 'package:recuperaposte/app/core/models/user_model.dart';

class HomeStore extends NotifierStore<Exception, UserModel> {
  HomeStore() : super(UserModel());
}
