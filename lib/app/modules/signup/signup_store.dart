import 'package:flutter_triple/flutter_triple.dart';
import 'package:recuperaposte/app/models/user_model.dart';

class SignupStore extends NotifierStore<Exception, UserModel> {
  SignupStore() : super(UserModel());

  Future<void> signup() async {
    setLoading(true);

    await Future.delayed(const Duration(seconds: 3));

    setLoading(false);
  }
}
