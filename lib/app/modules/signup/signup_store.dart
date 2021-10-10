import 'dart:developer';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:recuperaposte/app/core/models/user_model.dart';
import 'package:recuperaposte/app/modules/signup/signup_repository.dart';

class SignupStore extends NotifierStore<Exception, UserModel> {
  final SignupRepository _repository = Modular.get();

  SignupStore() : super(UserModel(isAdmin: false));

  Future<void> signup(String password) async {
    setLoading(true);

    await _repository.signup(userModel: state, password: password).catchError(
      (onError) {
        log(onError.toString());
        setError(onError);
        setLoading(false);
      },
    );

    setLoading(false);
  }

  void updateForm(UserModel model) {
    update(model);
  }
}
