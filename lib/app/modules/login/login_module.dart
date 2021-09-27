import 'package:recuperaposte/app/modules/login/login_Page.dart';
import 'package:recuperaposte/app/modules/login/login_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:recuperaposte/app/modules/signup/signup_module.dart';

class LoginModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => LoginStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const LoginPage()),
    ModuleRoute(
      '/signup',
      module: SignupModule(),
      transition: TransitionType.fadeIn,
    ),
  ];
}
