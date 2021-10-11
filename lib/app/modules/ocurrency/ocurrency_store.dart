import 'package:flutter_triple/flutter_triple.dart';
import 'package:recuperaposte/app/core/models/ocurrency_model.dart';

class OcurrencyStore extends NotifierStore<Exception, OcurrencyModel> {
  OcurrencyStore() : super(OcurrencyModel(status: 1));

  Future<void> registerOcurrency() {
    setLoading(true);

    setLoading(false);

    throw Exception();
  }
}
