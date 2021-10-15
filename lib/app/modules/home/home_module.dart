import 'package:flutter_modular/flutter_modular.dart';
import 'package:recuperaposte/app/modules/home/home_page.dart';
import 'package:recuperaposte/app/modules/home/pages/edit_user_page.dart';
import 'package:recuperaposte/app/modules/home/stores/home_store.dart';
// import 'package:recuperaposte/app/modules/login/pages/login_page.dart';
import 'package:recuperaposte/app/modules/ocurrency/ocurrency_module.dart';
import 'home_repository.dart';
import 'stores/edit_user_image_picked_store.dart';
import 'stores/quantity_ocurrency_home_card_store.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => HomeStore()),
    Bind.lazySingleton((i) => HomeRepository()),
    Bind.lazySingleton((i) => QuantityOcurrencyHomeCardStore()),
    Bind.lazySingleton((i) => EditUserImagePickerStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const HomePage(),
    ),
    ChildRoute('/edituser', child: (_, args) => const EditUserPage()),
    ModuleRoute('/ocurrency', module: OcurrencyModule())
  ];
}
