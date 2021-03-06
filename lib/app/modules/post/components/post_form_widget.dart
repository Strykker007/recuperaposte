import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recuperaposte/app/core/models/post_model.dart';
import 'package:recuperaposte/app/modules/post/stores/post_image_picked_store.dart';
import 'package:recuperaposte/app/modules/post/stores/post_store.dart';
import 'package:recuperaposte/app/shared/commom_dialog.dart';
import 'package:recuperaposte/app/shared/common_button_widget.dart';
import 'package:recuperaposte/app/shared/textfield_widget.dart';
import 'package:select_form_field/select_form_field.dart';

import 'post_image_picked_card_widget.dart';

class PostFormWidget extends StatefulWidget {
  const PostFormWidget({Key? key}) : super(key: key);

  @override
  State<PostFormWidget> createState() => _PostFormWidgetState();
}

class _PostFormWidgetState extends State<PostFormWidget> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey();
    final TextEditingController iluminationTypeController =
        TextEditingController();
    final TextEditingController postStatusController = TextEditingController();
    final TextEditingController postNumberController = TextEditingController();
    final TextEditingController postTypeController = TextEditingController();
    final TextEditingController addressController = TextEditingController();
    final TextEditingController ocupationController = TextEditingController();
    XFile? photo = XFile('');
    final ImagePicker imagePicker = ImagePicker();
    File photoToFile = File('');
    final PostImagePickerStore imagePickerStore = Modular.get();
    final PostStore store = Modular.get();

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
            child: TripleBuilder<PostImagePickerStore, Exception, File>(
              builder: (_, triple) {
                return PostImagePickedCardWidget(file: triple.state);
              },
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          TextFieldWidget(
            controller: postNumberController,
            prefixIcon: const Icon(Icons.text_snippet),
            label: 'N??mero do poste',
            validator: (text) {
              if (text!.isEmpty) {
                return 'Este campo n??o pode ser vazio';
              } else {
                return null;
              }
            },
            onSaved: (value) {
              postNumberController.text = value as String;
              store.state.postNumber = value;
            },
          ),
          const SizedBox(
            height: 15,
          ),
          SelectFormField(
            controller: postTypeController,
            type: SelectFormFieldType.dropdown,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.arrow_drop_down),
              hintText: 'Tipo de poste',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
            ),
            labelText: 'Shape',
            items: store.postTypes,
            onSaved: (val) {
              postTypeController.text = val as String;
              store.state.postType = val;
            },
          ),
          const SizedBox(
            height: 15,
          ),
          SelectFormField(
            controller: iluminationTypeController,
            type: SelectFormFieldType.dropdown,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.arrow_drop_down),
              hintText: 'Tipo de Ilumina????o',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
            ),
            labelText: 'Shape',
            items: store.iluminationTypes,
            onSaved: (val) {
              postTypeController.text = val as String;
              store.state.iluminationType = val;
            },
          ),
          const SizedBox(
            height: 15,
          ),
          SelectFormField(
            controller: postStatusController,
            type: SelectFormFieldType.dropdown,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.arrow_drop_down),
              hintText: 'Status do poste',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
            ),
            labelText: 'Shape',
            items: store.statusPosts,
            onSaved: (val) {
              postStatusController.text = val as String;
              store.state.postState = val;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          TextFieldWidget(
            controller: addressController,
            prefixIcon: const Icon(Icons.home),
            label: 'Endere??o',
            onSaved: (value) {
              addressController.text = value as String;
              store.state.address = value;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          TextFieldWidget(
            controller: ocupationController,
            prefixIcon: const Icon(Icons.text_snippet),
            label: 'Ocupa????es',
            onSaved: (value) {
              ocupationController.text = value as String;
              store.state.ocupation = value;
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
                      await store.registerPost(imagePickerStore.state).then(
                        (value) {
                          imagePickerStore.update(File(''));
                          postStatusController.text = '';
                          iluminationTypeController.text = '';
                          postTypeController.text = '';
                          _formKey.currentState!.reset();
                          showDialog(
                            context: context,
                            builder: (context) {
                              return const CommomDialog(
                                message: 'Poste criado com sucesso!',
                              );
                            },
                          );
                          store.update(PostModel());
                        },
                      ).catchError(
                        (onError) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return const CommomDialog(
                                message: 'Erro ao tentar criar um novo poste!',
                              );
                            },
                          );
                        },
                      );
                    }
                  },
            label: 'Registrar Poste',
          ),
        ],
      ),
    );
  }
}
