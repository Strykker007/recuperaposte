import 'package:flutter_modular/flutter_modular.dart';
import 'package:recuperaposte/app/modules/home/home_page.dart';
import 'package:recuperaposte/app/modules/home/home_store.dart';
import 'home_repository.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => HomeStore()),
    Bind.lazySingleton((i) => HomeRepository())
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const HomePage()),
  ];
}
