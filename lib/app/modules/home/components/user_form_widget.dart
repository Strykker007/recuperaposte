import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:recuperaposte/app/core/models/user_model.dart';
import 'package:recuperaposte/app/shared/commom_dialog.dart';
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
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
          Container(
            height: 40,
            alignment: Alignment.centerRight,
            child: TextButton(
              child: const Text(
                'Recuperar Senha',
              ),
              onPressed: () {
                Navigator.of(context).pushNamed('/passwordRecover');
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextButton(
            child: Text(
              'Não tem cadastro? Então cadastre-se!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.subtitle2!.fontSize,
                decoration: TextDecoration.underline,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pushNamed('/signup/');
            },
          ),
        ],
      ),
    );
  }
}
