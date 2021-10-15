import 'dart:developer';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:recuperaposte/app/core/models/user_model.dart';
import 'package:recuperaposte/app/modules/signup/signup_repository.dart';
import 'package:recuperaposte/app/stores/user_store.dart';

class SignupStore extends NotifierStore<Exception, UserModel> {
  final SignupRepository _repository = Modular.get();
  final UserStore userStore = Modular.get();

  SignupStore() : super(UserModel(isAdmin: false));

  Future<void> signup(String password) async {
    setLoading(true);

    UserModel user = UserModel();

    try {
      await _repository
          .signup(userModel: state, password: password)
          .then((value) {
        user = value as UserModel;
        userStore.update(user);
      }).catchError(
        (onError) {
          log(onError.toString());
          setLoading(false);

          setError(onError);
          throw onError;
        },
      );
    } catch (e) {
      setLoading(false);
      throw e;
    }
    await Future.delayed(const Duration(seconds: 2));
    setLoading(false);
  }

  void updateForm(UserModel model) {
    update(model);
  }
}
