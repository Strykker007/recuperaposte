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
  List<Map<String, dynamic>> problems = [];

  OcurrencyStore() : super(OcurrencyModel(status: 1, urgency: 'Baixa'));

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

  Future<OcurrencyModel> updateUrgency(OcurrencyModel ocurrency) async {
    setLoading(true);

    OcurrencyModel response = OcurrencyModel();

    try {
      await _repository.updateOcurrency(ocurrency).then((value) async {
        response = await _repository.getOcurrency(ocurrency.protocol!.toInt());
      }).catchError((onError) {
        log(onError.toString());
      });

      setLoading(false);
      return response;
    } catch (e) {
      setLoading(false);
      log(e.toString());
      throw Exception();
    }
  }

  Future<void> getProblemInfo() async {
    setLoading(true);

    try {
      problems = await _repository.getProblemInfo().catchError((onError) {
        log(onError.toString());
      });

      setLoading(false);
    } catch (e) {
      setLoading(false);
      log(e.toString());
      throw Exception();
    }
  }
}
