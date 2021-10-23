import 'package:flutter_modular/flutter_modular.dart';

import 'package:recuperaposte/app/modules/post/post_page.dart';
import 'package:recuperaposte/app/modules/post/stores/post_image_picked_store.dart';
import 'package:recuperaposte/app/modules/post/stores/post_store.dart';

import 'post_repository.dart';

class PostModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => PostStore()),
    Bind.lazySingleton((i) => PostRepository()),
    Bind.lazySingleton((i) => PostImagePickerStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const PostPage()),
  ];
}
