import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:recuperaposte/app/core/models/user_model.dart';
import 'package:recuperaposte/app/modules/login/login_repository.dart';
import 'package:recuperaposte/app/stores/user_store.dart';

class LoginStore extends NotifierStore<FirebaseException, UserModel> {
  final LoginRepository _repository = Modular.get();
  final UserStore userStore = Modular.get();

  LoginStore() : super(UserModel());

  Future<void> login({required String email, required String password}) async {
    setLoading(true);

    try {
      await _repository.login(email: email, password: password).then((user) {
        userStore.update(user as UserModel);
      }).catchError((onError) {
        setLoading(false);
        throw onError;
      });
    } catch (e) {
      setLoading(false);
      rethrow;
    }
  }

  Future<void> logout() async {
    setLoading(true);

    await _repository.logout().then(
      (value) {
        userStore.update(UserModel(isAdmin: false));
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
