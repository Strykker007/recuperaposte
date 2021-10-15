import 'package:flutter_modular/flutter_modular.dart';
import 'package:recuperaposte/app/modules/ocurrency/pages/admin_ocurrency_state_page.dart';

import 'ocurrency_repository.dart';
import 'pages/ocurrency_page.dart';
import 'stores/ocurrency_image_picked_store.dart';
import 'stores/ocurrency_manager_status_store.dart';
import 'stores/ocurrency_store.dart';

class OcurrencyModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => OcurrencyStore()),
    Bind.lazySingleton((i) => OcurrencyRepository()),
    Bind.lazySingleton((i) => OcurrencyImagePickerStore()),
    Bind.lazySingleton((i) => OcurrencyManagerStatusStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const OcurrencyPage()),
    ChildRoute('/manageOcurrency',
        child: (_, args) => const AdminOcurrencyStatusPage()),
  ];
}
