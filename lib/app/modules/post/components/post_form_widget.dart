import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:recuperaposte/app/modules/post/stores/image_picked_store.dart';
import 'package:recuperaposte/app/modules/post/stores/post_store.dart';
import 'package:recuperaposte/app/modules/post/components/image_picked_widget.dart';
import 'package:recuperaposte/app/shared/commom_dialog.dart';
import 'package:recuperaposte/app/shared/common_button_widget.dart';
import 'package:recuperaposte/app/shared/textfield_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PostFormWidget extends StatefulWidget {
  const PostFormWidget({Key? key}) : super(key: key);

  @override
  State<PostFormWidget> createState() => _PostFormWidgetState();
}

class _PostFormWidgetState extends State<PostFormWidget> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController codeController = TextEditingController();
    final TextEditingController statusController = TextEditingController();
    XFile? photo = XFile('');
    final ImagePicker imagePicker = ImagePicker();
    File photoToFile = File('');
    final ImagePickerStore imagePickerStore = Modular.get();
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
            prefixIcon: const Icon(Icons.emoji_objects),
            label: 'Tipo de poste',
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
            prefixIcon: const Icon(Icons.code),
            label: 'Código do Poste',
            controller: codeController,
            onSaved: (code) {
              codeController.text = code.toString();
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
            height: 20,
          ),
          TextFieldWidget(
            prefixIcon: const Icon(Icons.check),
            label: 'Status do Poste',
            controller: statusController,
            onSaved: (status) {
              codeController.text = status.toString();
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
                          .registerPost()
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
            label: 'Cadastrar Poste',
          ),
        ],
      ),
    );
  }
}
