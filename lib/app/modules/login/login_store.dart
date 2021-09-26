import 'package:flutter_triple/flutter_triple.dart';
import 'package:recuperaposte/app/models/user_model.dart';

class LoginStore extends NotifierStore<Exception, UserModel> {
  LoginStore() : super(UserModel());

  Future<void> login() async {
    setLoading(true);

    await Future.delayed(const Duration(seconds: 3));

    setLoading(false);
  }

  Future<void> logout() async {
    setLoading(true);

    await Future.delayed(const Duration(seconds: 3));

    setLoading(false);
  }
}
