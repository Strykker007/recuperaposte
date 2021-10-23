import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:recuperaposte/app/core/models/ocurrency_model.dart';
import 'package:recuperaposte/app/modules/ocurrency/ocurrency_repository.dart';

class OcurrencyDetailsStore extends NotifierStore<Exception, OcurrencyModel> {
  final OcurrencyRepository _repository = Modular.get();

  OcurrencyDetailsStore() : super(OcurrencyModel());

  Future<void> getOcurrencyByProtocol(int protocol) async {
    setLoading(true);

    try {
      await _repository.getOcurrencyByProtocol(protocol).then((value) {
        setLoading(false);
        update(value);
      }).catchError((onError) {
        setLoading(false);
        throw onError;
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateUrgency(OcurrencyModel model) async {
    setLoading(true);

    try {
      await _repository.updateOcurrency(model).then((value) {
        setLoading(false);
        update(model);
      }).catchError((onError) {
        setLoading(false);
        throw onError;
      });
    } catch (e) {
      rethrow;
    }
  }

  void dispose() {}
}
