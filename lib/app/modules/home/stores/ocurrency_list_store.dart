import 'dart:developer';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:recuperaposte/app/core/models/ocurrency_model.dart';
import 'package:recuperaposte/app/modules/home/home_repository.dart';
import 'package:recuperaposte/app/stores/user_store.dart';

class OcurrencyListStore
    extends NotifierStore<Exception, List<OcurrencyModel>> {
  final HomeRepository _repository = Modular.get();
  final UserStore userStore = Modular.get();

  OcurrencyListStore() : super([]);

  Future<void> getOcurrencies() async {
    setLoading(true);

    try {
      await _repository
          .getOcurrencies(userStore.state.id.toString())
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
}
