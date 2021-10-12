import 'package:flutter_triple/flutter_triple.dart';
import 'package:recuperaposte/app/core/models/ocurrency_model.dart';

class PostStore extends NotifierStore<Exception, OcurrencyModel> {
  PostStore() : super(OcurrencyModel(status: 1));

  Future<void> registerPost() {
    setLoading(true);

    setLoading(false);

    throw Exception();
  }
}
