import 'dart:developer';
import 'dart:io';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:recuperaposte/app/core/models/ocurrency_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:recuperaposte/app/modules/ocurrency/ocurrency_repository.dart';
import 'package:recuperaposte/app/stores/user_store.dart';

class OcurrencyStore extends NotifierStore<Exception, OcurrencyModel> {
  final OcurrencyRepository _repository = Modular.get();
  final UserStore userStore = Modular.get();

  OcurrencyStore() : super(OcurrencyModel(status: 1));

  Future<void> registerOcurrency(File image) async {
    setLoading(true);

    try {
      Position _position =
          await _repository.determinePosition().catchError((onError) {
        log(onError.toString());
      });
      state.latitude = _position.latitude;
      state.longitude = _position.longitude;
      state.userId = userStore.state.id;
      state.date = DateTime.now().toString();

      await _repository.registerOcurrency(state, image);

      setLoading(false);
    } catch (e) {
      setLoading(false);
      log(e.toString());
      throw Exception();
    }

    setLoading(false);
  }
}
