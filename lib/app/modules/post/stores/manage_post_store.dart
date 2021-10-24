import 'dart:developer';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:recuperaposte/app/core/models/post_model.dart';
import 'package:recuperaposte/app/modules/post/post_repository.dart';

class ManagePostStore extends NotifierStore<Exception, List<PostModel>> {
  final PostRepository _repository = Modular.get();
  ManagePostStore() : super([]);

  Future<void> getPosts() async {
    setLoading(true);

    try {
      await _repository.getPosts().then((value) {
        setLoading(false);
        update(value);
      });
    } catch (e) {
      setLoading(false);
      log(e.toString());
      throw Exception();
    }
  }

  Future<void> deletePost(String postNumber) async {
    setLoading(true);

    try {
      await _repository.deletePost(postNumber).then((value) {
        setLoading(false);
      });
    } catch (e) {
      setLoading(false);
      log(e.toString());
      throw Exception();
    }
  }
}
