import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:recuperaposte/app/core/models/ocurrency_model.dart';
import 'package:recuperaposte/app/modules/ocurrency/components/ocurrency_image_picked_card_widget.dart';

import 'package:recuperaposte/app/modules/ocurrency/stores/ocurrency_image_picked_store.dart';
import 'package:recuperaposte/app/modules/ocurrency/stores/ocurrency_store.dart';
import 'package:select_form_field/select_form_field.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController postTypeController = TextEditingController();
  XFile? photo = XFile('');
  final ImagePicker imagePicker = ImagePicker();
  File photoToFile = File('');
  final OcurrencyImagePickerStore imagePickerStore = Modular.get();
  final OcurrencyStore store = Modular.get();

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
            child: TripleBuilder<OcurrencyImagePickerStore, Exception, File>(
              builder: (_, triple) {
                return OcurrencyImagePickedCardWidget(file: triple.state);
              },
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const SizedBox(
            height: 15,
          ),
          TextFieldWidget(
            prefixIcon: const Icon(Icons.list_alt),
            label: 'Descrição',
            controller: descriptionController,
            onSaved: (description) {
              store.state.description = description;
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
            height: 15,
          ),
          TextFieldWidget(
            prefixIcon: const Icon(Icons.home),
            label: 'Endereço',
            controller: addressController,
            onSaved: (address) {
              store.state.address = address;
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
            height: 15,
          ),
          SelectFormField(
            controller: postTypeController,
            type: SelectFormFieldType.dropdown,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.list),
              hintText: 'Problema',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
            ),
            labelText: 'Problema',
            items: store.problems,
            onSaved: (val) {
              postTypeController.text = val as String;
              store.state.problemType = val;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          CommonButtonWidget(
            onTap: store.isLoading
                ? null
                : () async {
                    if (_formKey.currentState!.validate() &&
                        imagePickerStore.state.path.isNotEmpty) {
                      _formKey.currentState!.save();
                      await store
                          .registerOcurrency(imagePickerStore.state)
                          .then(
                        (value) {
                          imagePickerStore.update(File(''));
                          _formKey.currentState!.reset();
                          store.update(OcurrencyModel());
                          showDialog(
                            context: context,
                            builder: (context) {
                              return const CommomDialog(
                                message: 'Ocorrência enviada com sucesso!',
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
