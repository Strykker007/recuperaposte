import 'package:flutter_triple/flutter_triple.dart';
import 'dart:io';

class PostImagePickerStore extends NotifierStore<Exception, File> {
  PostImagePickerStore() : super(File(''));
}
