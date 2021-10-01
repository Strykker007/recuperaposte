import 'package:flutter_modular/flutter_modular.dart';
import 'package:recuperaposte/app/modules/home/home_page.dart';
<<<<<<< HEAD
import 'package:recuperaposte/app/modules/home/home_store.dart';
import 'package:recuperaposte/app/modules/login/login_module.dart';
=======
import '../home/home_store.dart';
import 'home_repository.dart';
>>>>>>> create_signup_repository

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => HomeStore()),
    Bind.lazySingleton((i) => HomeRepository())
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const HomePage()),
<<<<<<< HEAD
    ModuleRoute(
      '/login',
      module: LoginModule(),
      transition: TransitionType.fadeIn,
    ),
=======
>>>>>>> create_signup_repository
  ];
}
