import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:recuperaposte/app/shared/image_picked_card_widget.dart';

import 'package:recuperaposte/app/modules/ocurrency/ocurrency_store.dart';
import 'package:recuperaposte/app/modules/ocurrency/stores/image_picker_store.dart';
import 'package:recuperaposte/app/shared/commom_dialog.dart';
import 'package:recuperaposte/app/shared/common_button_widget.dart';
import 'package:recuperaposte/app/shared/textfield_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class OcurrencyFormWidget extends StatefulWidget {
  const OcurrencyFormWidget({Key? key}) : super(key: key);

  @override
  State<OcurrencyFormWidget> createState() => _OcurrencyFormWidgetState();
}

class _OcurrencyFormWidgetState extends State<OcurrencyFormWidget> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    XFile? photo = XFile('');
    final ImagePicker imagePicker = ImagePicker();
    File photoToFile = File('');
    final ImagePickerStore imagePickerStore = Modular.get();
    final OcurrencyStore store = Modular.get();

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
            child: TripleBuilder<ImagePickerStore, Exception, File>(
              builder: (_, triple) {
                return ImagePickedCardWidget(file: triple.state);
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFieldWidget(
            textInputType: TextInputType.text,
            prefixIcon: const Icon(Icons.light),
            label: 'Número do poste',
            controller: emailController,
            onSaved: (email) {
              emailController.text = email.toString();
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
            prefixIcon: const Icon(Icons.list_alt),
            label: 'Descrição',
            controller: passwordController,
            onSaved: (password) {
              passwordController.text = password.toString();
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
            height: 10,
          ),
          CommonButtonWidget(
            onTap: store.isLoading
                ? null
                : () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      await store
                          .registerOcurrency()
                          .then(
                            (value) {},
                          )
                          .catchError(
                        (onError) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return const CommomDialog(
                                message:
                                    'Erro ao tentar criar uma nova ocorrência!',
                              );
                            },
                          );
                        },
                      );
                    }
                  },
            label: 'Registrar ocorrência',
          ),
        ],
      ),
    );
  }
}
