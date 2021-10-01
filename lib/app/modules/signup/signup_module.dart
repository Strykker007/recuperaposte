import 'package:recuperaposte/app/modules/signup/signup_Page.dart';
import 'package:recuperaposte/app/modules/signup/signup_repository.dart';
import 'package:recuperaposte/app/modules/signup/signup_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SignupModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => SignupStore()),
<<<<<<< HEAD
    Bind.lazySingleton((i) => SignupRepository()),
=======
    Bind.lazySingleton((i) => SignupRepository())
>>>>>>> create_signup_repository
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const SignupPage()),
  ];
}
