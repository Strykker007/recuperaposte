import 'package:flutter_triple/flutter_triple.dart';
import 'dart:io';

class OcurrencyImagePickerStore extends NotifierStore<Exception, File> {
  OcurrencyImagePickerStore() : super(File(''));
}
