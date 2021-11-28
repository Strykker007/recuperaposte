import 'package:flutter_modular/flutter_modular.dart';

import 'package:recuperaposte/app/modules/post/pages/post_page.dart';
import 'package:recuperaposte/app/modules/post/stores/manage_post_store.dart';
import 'package:recuperaposte/app/modules/post/stores/post_image_picked_store.dart';

import 'pages/manage_post_page.dart';

class PostModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => PostImagePickerStore()),
    Bind.lazySingleton((i) => ManagePostStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const PostPage()),
    ChildRoute('/managePost', child: (_, args) => const ManagePostPage()),
  ];
}
