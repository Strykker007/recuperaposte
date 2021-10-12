import 'package:flutter_modular/flutter_modular.dart';
import 'package:recuperaposte/app/modules/ocurrency/stores/image_picker_store.dart';
import 'package:recuperaposte/app/modules/post/post_page.dart';
import 'package:recuperaposte/app/modules/post/post_store.dart';

import 'post_repository.dart';

class PostModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => PostStore()),
    Bind.lazySingleton((i) => PostRepository()),
    Bind.lazySingleton((i) => ImagePickerStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const PostPage()),
  ];
}
