import 'package:flutter_triple/flutter_triple.dart';
import 'dart:io';

class EditUserImagePickerStore extends NotifierStore<Exception, File> {
  EditUserImagePickerStore() : super(File(''));
}
