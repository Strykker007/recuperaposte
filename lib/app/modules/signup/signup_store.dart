import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:recuperaposte/app/core/models/user_model.dart';
import 'package:recuperaposte/app/modules/login/login_repository.dart';

class SignupStore extends NotifierStore<Exception, UserModel> {
  final LoginRepository _repository = Modular.get();

  SignupStore() : super(UserModel());

  Future<void> signup(String password) async {
    setLoading(true);

    final user = (await _auth.createUserWithEmailAndPassword(
      email: state.email,
      password: password,
    ))
        .user;

    setLoading(false);
  }

  void updateForm(UserModel model) {
    update(model);
  }
}
