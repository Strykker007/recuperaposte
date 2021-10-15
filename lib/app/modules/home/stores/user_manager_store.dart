import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:recuperaposte/app/core/models/user_model.dart';
import 'package:recuperaposte/app/modules/home/home_repository.dart';

class UserManagerStore extends NotifierStore<Exception, List<UserModel>> {
  final HomeRepository _repository = Modular.get();
  String searchText = '';
  UserManagerStore() : super([]);

  Future<void> getUsers() async {
    setLoading(true);

    await _repository.getUsers().then((value) {
      update(value);
    }).catchError(
      (onError) {
        throw onError;
      },
    );

    setLoading(false);
  }

  Future<void> getFilteredUsers(String name) async {
    setLoading(true);

    await _repository.getFilteredUsers(name).then((value) {
      update(value);
    }).catchError(
      (onError) {
        throw onError;
      },
    );

    setLoading(false);
  }

  Future<void> updateUser(UserModel user) async {
    setLoading(true);

    bool checkPrivileges = user.isAdmin as bool;

    user.isAdmin = !checkPrivileges;

    await _repository.updateUser(user).catchError(
      (onError) {
        throw onError;
      },
    );

    setLoading(false);
  }
}
