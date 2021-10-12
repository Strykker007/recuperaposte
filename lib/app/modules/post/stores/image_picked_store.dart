import 'package:flutter_triple/flutter_triple.dart';
import 'dart:io';

class ImagePickerStore extends NotifierStore<Exception, File> {
  ImagePickerStore() : super(File(''));
}
