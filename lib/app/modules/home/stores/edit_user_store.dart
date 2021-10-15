import 'dart:io';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:recuperaposte/app/core/models/user_model.dart';
import 'package:recuperaposte/app/modules/home/home_repository.dart';

class EditUserStore extends NotifierStore<Exception, UserModel> {
  final HomeRepository _repository = Modular.get();
  EditUserStore() : super(UserModel());

  Future<void> editUser(UserModel newUser, File image) async {
    setLoading(true);

    UserModel model = await _repository.editUser(newUser, image);
    update(model);
    setLoading(false);
  }
}
