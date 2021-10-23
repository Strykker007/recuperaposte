import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recuperaposte/app/core/models/user_model.dart';
import 'package:recuperaposte/app/modules/home/components/edit_user_image_picked_card_widget.dart';
import 'package:recuperaposte/app/modules/home/stores/edit_user_image_picked_store.dart';
import 'package:recuperaposte/app/modules/home/stores/edit_user_store.dart';
import 'package:recuperaposte/app/shared/commom_dialog.dart';
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
  XFile? photo = XFile('');
  File photoToFile = File('');

  final UserStore userStore = Modular.get();
  final EditUserStore editUserStore = Modular.get();
  final GlobalKey<FormState> _formKey = GlobalKey();
  final ImagePicker imagePicker = ImagePicker();
  final EditUserImagePickerStore imagePickerStore = Modular.get();

  @override
  Widget build(BuildContext context) {
    if (widget.user.avatarUrl != null) {
      photoToFile = File('');
      imagePickerStore.update(photoToFile);
    }

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
                return EditUserImagePickedCardWidget(
                  url: widget.user.avatarUrl == null
                      ? ''
                      : widget.user.avatarUrl as String,
                  file: photoToFile,
                );
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
            onSaved: (name) {
              userStore.state.name = name;
              userStore.update(userStore.state);
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
            onSaved: (address) {
              userStore.state.address = address;
              userStore.update(userStore.state);
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
          CommonButtonWidget(
            onTap: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                await editUserStore
                    .editUser(userStore.state, imagePickerStore.state)
                    .then(
                  (value) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const CommomDialog(
                          message: 'Perfil atualizado com sucesso!',
                        );
                      },
                    );
                  },
                ).catchError(
                  (onError) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const CommomDialog(
                          message: 'Erro ao salvar os dados!',
                        );
                      },
                    );
                  },
                );
              }
            },
            label: 'Salvar',
          ),
        ],
      ),
    );
  }
}
