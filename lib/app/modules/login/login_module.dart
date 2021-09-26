import 'package:recuperaposte/app/modules/login/login_Page.dart';
import 'package:recuperaposte/app/modules/login/login_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:recuperaposte/app/modules/signup/signup_page.dart';
import 'package:recuperaposte/app/modules/signup/signup_store.dart';

class LoginModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => LoginStore()),
    Bind.lazySingleton((i) => SignupStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const LoginPage()),
    ChildRoute('/signup', child: (_, args) => const SignupPage()),
  ];
}
