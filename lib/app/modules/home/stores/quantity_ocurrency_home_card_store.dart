import 'dart:developer';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:recuperaposte/app/core/models/ocurrency_model.dart';
import 'package:recuperaposte/app/core/models/ocurrency_quantity_model.dart';
import 'package:recuperaposte/app/modules/home/home_repository.dart';
import 'package:recuperaposte/app/stores/user_store.dart';

class QuantityOcurrencyHomeCardStore
    extends NotifierStore<Exception, OcurrencyQuantityModel> {
  final UserStore userStore = Modular.get();
  final HomeRepository _repository = Modular.get();
  QuantityOcurrencyHomeCardStore()
      : super(OcurrencyQuantityModel(
            inCurse: 0, opened: 0, canceled: 0, completed: 0));

  Future<void> getQuantityOcurrencies() async {
    setLoading(true);
    state.canceled = 0;
    state.opened = 0;
    state.completed = 0;
    state.inCurse = 0;

    update(state);

    List<OcurrencyModel> resultList = [];

    try {
      resultList =
          await _repository.getOcurrencies(userStore.state.id.toString());

      for (var element in resultList) {
        if (element.status == 1) {
          state.opened = state.opened! + 1;
        }
        if (element.status == 2) {
          state.inCurse = state.inCurse! + 1;
        }
        if (element.status == 3) {
          state.completed = state.completed! + 1;
        }
        if (element.status == 4) {
          state.canceled = state.canceled! + 1;
        }
      }
      update(state);
    } catch (e) {
      log(e.toString());
      setLoading(false);
      rethrow;
    }

    setLoading(false);
  }
}
