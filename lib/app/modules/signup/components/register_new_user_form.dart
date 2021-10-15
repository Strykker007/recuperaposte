import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:recuperaposte/app/core/models/user_model.dart';
import 'package:recuperaposte/app/modules/login/stores/login_store.dart';
import 'package:recuperaposte/app/modules/signup/signup_store.dart';
import 'package:recuperaposte/app/shared/commom_dialog.dart';
import 'package:recuperaposte/app/shared/common_button_widget.dart';
import 'package:recuperaposte/app/shared/textfield_widget.dart';

class RegisterNewUserFormWidget extends StatelessWidget {
  const RegisterNewUserFormWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SignupStore store = Modular.get();
    final GlobalKey<FormState> _formKey = GlobalKey();
    final TextEditingController password1 = TextEditingController();
    final TextEditingController password2 = TextEditingController();

    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Formulário de Cadastro',
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.headline6!.fontSize,
              color: Theme.of(context).primaryColor,
            ),
          ),
          SizedBox(
            height: 15,
            child: Divider(
              color: Theme.of(context).primaryColor,
            ),
          ),
          Text(
            'Dados Pessoais',
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.headline6!.fontSize,
              color: Theme.of(context).primaryColor,
              decoration: TextDecoration.underline,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          TextFieldWidget(
            textInputType: TextInputType.text,
            prefixIcon: const Icon(Icons.person),
            label: 'Nome',
            onChanged: (value) {
              store.state.name = value;
              store.updateForm(store.state);
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
          TextFieldWidget(
            textInputType: TextInputType.text,
            prefixIcon: const Icon(Icons.home),
            label: 'Endereço',
            onChanged: (value) {
              store.state.address = value;
              store.updateForm(store.state);
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
          SizedBox(
            height: 15,
            child: Divider(
              color: Theme.of(context).primaryColor,
            ),
          ),
          Text(
            'Dados de Acesso',
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.headline6!.fontSize,
              color: Theme.of(context).primaryColor,
              decoration: TextDecoration.underline,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          TextFieldWidget(
            textInputType: TextInputType.emailAddress,
            prefixIcon: const Icon(Icons.home),
            label: 'E-mail',
            onChanged: (value) {
              store.state.email = value;
              store.updateForm(store.state);
            },
            validator: (text) {
              if (text!.isEmpty || !text.contains('@') || !text.contains('.')) {
                return 'E-mail inválido';
              } else {
                return null;
              }
            },
          ),
          const SizedBox(
            height: 10,
          ),
          TextFieldWidget(
            textInputType: TextInputType.text,
            prefixIcon: const Icon(Icons.lock),
            obscureText: true,
            controller: password1,
            label: 'Senha',
            onSaved: (value) {
              password1.text = value.toString();
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
          TextFieldWidget(
            textInputType: TextInputType.text,
            prefixIcon: const Icon(Icons.lock),
            obscureText: true,
            controller: password2,
            label: 'Confirmar Senha',
            onSaved: (value) {
              password2.text = value.toString();
            },
            validator: (text) {
              if (text!.isEmpty) {
                return 'Este campo não pode ser vazio';
              }
              if (password1.text != password2.text) {
                return 'As senhas não conferem';
              } else {
                return null;
              }
            },
          ),
          const SizedBox(
            height: 15,
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
                              .signup(password1.text)
                              .then((value) async {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return const CommomDialog(
                                  disableCloseButtom: true,
                                  message: 'Usuário criado com sucesso!',
                                );
                              },
                            );
                            await Future.delayed(const Duration(seconds: 2))
                                .then((value) => Modular.to.pop());
                            Modular.to.pushReplacementNamed('/home');
                          }).catchError(
                            (onError) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return CommomDialog(
                                      message:
                                          'Ops! Ocorreu um erro inesperado ${onError.toString()}');
                                },
                              );
                            },
                          );
                        }
                      },
                label: 'Cadastrar',
              );
            },
          ),
        ],
      ),
    );
  }
}
