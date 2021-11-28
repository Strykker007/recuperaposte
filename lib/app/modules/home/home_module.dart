import 'package:flutter_modular/flutter_modular.dart';
import 'package:recuperaposte/app/modules/home/home_page.dart';
import 'package:recuperaposte/app/modules/home/pages/edit_user_page.dart';
import 'package:recuperaposte/app/modules/home/pages/ocurrency_list_page.dart';
import 'package:recuperaposte/app/modules/home/stores/home_store.dart';
import 'package:recuperaposte/app/modules/home/stores/ocurrency_list_store.dart';
import 'package:recuperaposte/app/modules/home/stores/search_textfield_store.dart';
// import 'package:recuperaposte/app/modules/login/pages/login_page.dart';
import 'package:recuperaposte/app/modules/ocurrency/ocurrency_module.dart';
import 'package:recuperaposte/app/modules/ocurrency/ocurrency_repository.dart';
import 'package:recuperaposte/app/modules/ocurrency/stores/ocurrency_store.dart';
import 'package:recuperaposte/app/modules/post/post_module.dart';
import 'package:recuperaposte/app/modules/post/post_repository.dart';
import 'package:recuperaposte/app/modules/post/stores/post_store.dart';
import 'home_repository.dart';
import 'pages/user_manager_page.dart';
import 'stores/edit_user_image_picked_store.dart';
import 'stores/edit_user_store.dart';
import 'stores/quantity_ocurrency_home_card_store.dart';
import 'stores/user_manager_store.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => HomeStore()),
    Bind.lazySingleton((i) => HomeRepository()),
    Bind.lazySingleton((i) => QuantityOcurrencyHomeCardStore()),
    Bind.lazySingleton((i) => EditUserImagePickerStore()),
    Bind.lazySingleton((i) => EditUserStore()),
    Bind.lazySingleton((i) => UserManagerStore()),
    Bind.lazySingleton((i) => SearchTextFieldStore()),
    Bind.lazySingleton((i) => OcurrencyListStore()),
    Bind.lazySingleton((i) => OcurrencyStore()),
    Bind.lazySingleton((i) => OcurrencyRepository()),
    Bind.lazySingleton((i) => PostStore()),
    Bind.lazySingleton((i) => PostRepository()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const HomePage(),
    ),
    ChildRoute('/edituser', child: (_, args) => const EditUserPage()),
    ChildRoute('/userManager', child: (_, args) => const UserManagerPage()),
    ChildRoute('/ocurrencyList', child: (_, args) => const OcurrencyListPage()),
    ModuleRoute('/ocurrency', module: OcurrencyModule()),
    ModuleRoute('/createPost', module: PostModule()),
  ];
}
