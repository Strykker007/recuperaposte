import 'package:flutter_triple/flutter_triple.dart';
import 'package:recuperaposte/app/core/models/ocurrency_quantity_model.dart';

class QuantityOcurrencyHomeCardStore
    extends NotifierStore<Exception, OcurrencyQuantityModel> {
  QuantityOcurrencyHomeCardStore()
      : super(OcurrencyQuantityModel(
            inCurse: 0, opened: 0, canceled: 0, completed: 0));
}
