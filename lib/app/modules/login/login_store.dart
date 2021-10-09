// import 'package:flutter_modular/flutter_modular.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:recuperaposte/app/core/models/user_model.dart';
import 'package:recuperaposte/app/modules/login/login_repository.dart';

class LoginStore extends NotifierStore<FirebaseException, UserModel> {
  final LoginRepository _repository = Modular.get();

  LoginStore() : super(UserModel());

  Future<void> login({required String email, required String password}) async {
    setLoading(true);

    await _repository.login(email: email, password: password).then((user) {
      UserModel model = UserModel();
      model.email = user!['email'];
      model.name = user['name'];
      model.address = user['address'];
      update(model);
    }).catchError((onError) {
      setLoading(false);
      update(UserModel());
      throw onError;
    });

    setLoading(false);
  }

  Future<void> logout() async {
    setLoading(true);

    await _repository.logout().then(
      (value) {
        update(UserModel());
      },
    ).catchError((onError) {
      setLoading(false);
      setError(onError);
    });

    setLoading(false);
  }

  Future<void> passwordRecovery(String email) async {
    setLoading(true);
    await _repository.passwordRecovery(email).catchError((onError) {
      setLoading(false);
      setError(onError);
    });

    setLoading(false);
  }
}
