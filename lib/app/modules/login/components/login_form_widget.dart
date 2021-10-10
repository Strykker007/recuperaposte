import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:recuperaposte/app/core/models/user_model.dart';
import 'package:recuperaposte/app/modules/login/stores/login_store.dart';
import 'package:recuperaposte/app/modules/login/stores/password_field_store.dart';
import 'package:recuperaposte/app/shared/commom_dialog.dart';
import 'package:recuperaposte/app/shared/common_button_widget.dart';
import 'package:recuperaposte/app/shared/textfield_widget.dart';

class LoginFormWidget extends StatelessWidget {
  const LoginFormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final PasswordFieldStore passwordStore = Modular.get();
    final LoginStore store = Modular.get();

    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFieldWidget(
            textInputType: TextInputType.emailAddress,
            prefixIcon: const Icon(Icons.login),
            label: 'E-mail',
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
          TripleBuilder<PasswordFieldStore, Exception, bool>(
            builder: (_, triple) {
              return TextFieldWidget(
                obscureText: triple.state,
                prefixIcon: const Icon(Icons.lock),
                label: 'Senha',
                controller: passwordController,
                onSaved: (password) {
                  passwordController.text = password.toString();
                },
                suffixIcon: IconButton(
                  icon: triple.state
                      ? const Icon(Icons.visibility_off_outlined)
                      : const Icon(Icons.remove_red_eye_outlined),
                  onPressed: () {
                    passwordStore.setObscureText(!triple.state);
                  },
                ),
                validator: (text) {
                  if (text!.isEmpty) {
                    return 'Este campo não pode ser vazio';
                  } else {
                    return null;
                  }
                },
              );
            },
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
          TripleBuilder<LoginStore, Exception, UserModel>(
            builder: (_, triple) {
              return CommonButtonWidget(
                onTap: store.isLoading
                    ? null
                    : () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          await store
                              .login(
                            email: emailController.text,
                            password: passwordController.text,
                          )
                              .then(
                            (value) {
                              Navigator.of(context)
                                  .pushReplacementNamed('/home/');
                            },
                          ).catchError(
                            (onError) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return const CommomDialog(
                                    message:
                                        'Erro ao tentar realizar o login, por favor verifique se o usuário e senha estão corretos!',
                                  );
                                },
                              );
                            },
                          );
                        }
                      },
                label: 'Login',
              );
            },
          ),
        ],
      ),
    );
  }
}
