import 'dart:developer';
import 'dart:io';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:geolocator/geolocator.dart';
import 'package:recuperaposte/app/core/models/post_model.dart';
import 'package:recuperaposte/app/modules/post/post_repository.dart';

class PostStore extends NotifierStore<Exception, PostModel> {
  final PostRepository _repository = Modular.get();
  PostStore() : super(PostModel());

  Future<void> registerPost(File file) async {
    setLoading(true);

    try {
      Position _position =
          await _repository.determinePosition().catchError((onError) {
        log(onError.toString());
      });
      state.latitude = _position.latitude;
      state.longitude = _position.longitude;
      state.date = DateTime.now().toString();

      await _repository.createPost(state, file);

      setLoading(false);
    } catch (e) {
      setLoading(false);
      log(e.toString());
      throw Exception();
    }
  }
}
