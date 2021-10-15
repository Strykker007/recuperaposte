import 'package:flutter_modular/flutter_modular.dart';
import 'package:recuperaposte/app/modules/login/login_module.dart';

import 'modules/signup/signup_module.dart';
import 'stores/user_store.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => UserStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: LoginModule()),
    ModuleRoute(
      '/signup',
      module: SignupModule(),
      transition: TransitionType.fadeIn,
    ),
  ];
}
