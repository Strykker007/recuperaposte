import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recuperaposte/app/core/models/user_model.dart';
import 'package:recuperaposte/app/modules/home/components/edit_user_image_picked_card_widget.dart';
import 'package:recuperaposte/app/modules/home/stores/edit_user_image_picked_store.dart';
import 'package:recuperaposte/app/shared/common_button_widget.dart';
import 'package:recuperaposte/app/shared/textfield_widget.dart';

import 'package:recuperaposte/app/stores/user_store.dart';

class UserFormWidget extends StatefulWidget {
  final UserModel user;
  const UserFormWidget({Key? key, required this.user}) : super(key: key);

  @override
  _UserFormWidgetState createState() => _UserFormWidgetState();
}

class _UserFormWidgetState extends State<UserFormWidget> {
  final UserStore userStore = Modular.get();
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController nameController = TextEditingController();
  final EditUserImagePickerStore imagePickerStore = Modular.get();
  XFile? photo = XFile('');
  final ImagePicker imagePicker = ImagePicker();
  File photoToFile = File('');
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () async {
              photo = await imagePicker.pickImage(source: ImageSource.gallery);

              photoToFile = File(photo!.path);
              imagePickerStore.update(photoToFile);
            },
            child: TripleBuilder<EditUserImagePickerStore, Exception, File>(
              builder: (_, triple) {
                return EditUserImagePickedCardWidget(file: triple.state);
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFieldWidget(
            initialValue: widget.user.name,
            textInputType: TextInputType.emailAddress,
            prefixIcon: const Icon(Icons.login),
            label: 'Nome',
            // controller: nameController,
            onSaved: (email) {
              // nameController.text = email.toString();
            },
            validator: (text) {
              if (text!.isEmpty) {
                return 'Este campo não pode ser vazio';
              } else {
                return null;
              }
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextFieldWidget(
            initialValue: widget.user.address,
            textInputType: TextInputType.emailAddress,
            prefixIcon: const Icon(Icons.login),
            label: 'Endereço',
            // controller: nameController,
            onSaved: (address) {
              // nameController.text = email.toString();
            },
            validator: (text) {
              if (text!.isEmpty) {
                return 'Este campo não pode ser vazio';
              } else {
                return null;
              }
            },
          ),
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            height: 20,
          ),
          CommonButtonWidget(onTap: () {}, label: 'Alterar')
        ],
      ),
    );
  }
}
