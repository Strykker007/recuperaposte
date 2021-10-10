import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:recuperaposte/app/modules/login/stores/login_store.dart';
import 'package:recuperaposte/app/shared/common_button_widget.dart';
import 'package:recuperaposte/app/shared/textfield_widget.dart';

class OcurrencyFormWidget extends StatelessWidget {
  const OcurrencyFormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final LoginStore store = Modular.get();

    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
                    // if (_formKey.currentState!.validate()) {
                    //   _formKey.currentState!.save();
                    //   await store
                    //       .login(
                    //     email: emailController.text,
                    //     password: passwordController.text,
                    //   )
                    //       .then(
                    //     (value) {
                    //       Navigator.of(context).pushReplacementNamed('/home/');
                    //     },
                    //   ).catchError(
                    //     (onError) {
                    //       showDialog(
                    //         context: context,
                    //         builder: (context) {
                    //           return const CommomDialog(
                    //             message:
                    //                 'Erro ao tentar realizar o login, por favor verifique se o usuário e senha estão corretos!',
                    //           );
                    //         },
                    //       );
                    //     },
                    //   );
                    // }
                  },
            label: 'Registrar ocorrência',
          ),
        ],
      ),
    );
  }
}
