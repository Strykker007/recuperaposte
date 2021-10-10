import 'package:recuperaposte/app/modules/ocurrency/ocurrency_Page.dart';
import 'package:recuperaposte/app/modules/ocurrency/ocurrency_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'ocurrency_repository.dart';

class OcurrencyModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => OcurrencyStore()),
    Bind.lazySingleton((i) => OcurrencyRepository()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const OcurrencyPage()),
  ];
}
