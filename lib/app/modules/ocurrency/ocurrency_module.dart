import 'package:recuperaposte/app/modules/ocurrency/ocurrency_Page.dart';
import 'package:recuperaposte/app/modules/ocurrency/ocurrency_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'ocurrency_repository.dart';
import 'stores/ocurrency_image_picked_store.dart';

class OcurrencyModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => OcurrencyStore()),
    Bind.lazySingleton((i) => OcurrencyRepository()),
    Bind.lazySingleton((i) => OcurrencyImagePickerStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const OcurrencyPage()),
  ];
}
