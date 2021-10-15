import 'package:recuperaposte/app/modules/home/home_module.dart';
import 'package:recuperaposte/app/modules/login/login_repository.dart';
import 'package:recuperaposte/app/modules/login/stores/login_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:recuperaposte/app/modules/login/stores/password_field_store.dart';

import 'pages/login_page.dart';
import 'pages/password_recovery_page.dart';

class LoginModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => LoginStore()),
    Bind.lazySingleton((i) => LoginRepository()),
    Bind.lazySingleton((i) => PasswordFieldStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const LoginPage()),
    ChildRoute('/passwordRecover',
        child: (_, args) => const PasswordRecoverPage()),
    ModuleRoute(
      '/home',
      module: HomeModule(),
      transition: TransitionType.fadeIn,
    ),
  ];
}
