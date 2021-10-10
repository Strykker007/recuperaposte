import 'package:flutter_triple/flutter_triple.dart';
import 'package:recuperaposte/app/core/models/ocurrency_model.dart';

class HomeStore extends NotifierStore<Exception, OcurrencyModel> {
  HomeStore() : super(OcurrencyModel());
}
