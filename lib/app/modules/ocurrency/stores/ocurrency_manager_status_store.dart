import 'dart:developer';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:recuperaposte/app/core/models/ocurrency_model.dart';
import 'package:recuperaposte/app/modules/ocurrency/ocurrency_repository.dart';
import 'package:recuperaposte/app/stores/user_store.dart';

class OcurrencyManagerStatusStore
    extends NotifierStore<Exception, List<OcurrencyModel>> {
  final OcurrencyRepository _repository = Modular.get();
  final UserStore userStore = Modular.get();

  OcurrencyManagerStatusStore() : super([]);

  Future<void> getOcurrencies() async {
    setLoading(true);

    try {
      await _repository.getOcurrencies().then((ocurrencies) {
        update(ocurrencies);
      });
      setLoading(false);
    } catch (e) {
      setLoading(false);
      log(e.toString());
      throw Exception();
    }

    setLoading(false);
  }

  Future<void> getFilteredOcurrencies(String protocol) async {
    setLoading(true);

    int protocolToInt = int.parse(protocol);

    try {
      await _repository
          .getFilteredOcurrencies(protocolToInt)
          .then((ocurrencies) {
        update(ocurrencies);
      });
      setLoading(false);
    } catch (e) {
      setLoading(false);
      log(e.toString());
      throw Exception();
    }
    setLoading(false);
  }

  Future<void> updateOcurrency(
      OcurrencyModel ocurrency, String operation) async {
    setLoading(true);
    int currentStatus = ocurrency.status as int;
    if (operation == 'next') {
      ocurrency.status = currentStatus + 1;
    }
    if (operation == 'previous') {
      ocurrency.status = currentStatus - 1;
    }
    if (operation == 'cancel') {
      ocurrency.status = 4;
    }

    try {
      await _repository.updateOcurrency(ocurrency);
      setLoading(false);
    } catch (e) {
      setLoading(false);
      log(e.toString());
      throw Exception();
    }
    setLoading(false);
  }

  Future<void> updateUrgency(OcurrencyModel ocurrency) async {
    setLoading(true);

    try {
      await _repository.updateOcurrency(ocurrency);
      setLoading(false);
    } catch (e) {
      setLoading(false);
      log(e.toString());
      throw Exception();
    }
    setLoading(false);
  }
}
