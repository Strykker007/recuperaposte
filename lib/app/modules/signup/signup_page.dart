import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:recuperaposte/app/core/models/user_model.dart';
import 'package:recuperaposte/app/modules/login/stores/login_store.dart';
import 'package:recuperaposte/app/modules/signup/signup_store.dart';
import 'package:recuperaposte/app/shared/arrow_back_widget.dart';
import 'package:recuperaposte/app/shared/background_widget.dart';
import 'package:recuperaposte/app/shared/commom_dialog.dart';
import 'package:recuperaposte/app/shared/common_button_widget.dart';
import 'package:recuperaposte/app/shared/loading_widget.dart';

import 'package:flutter/material.dart';
import 'package:recuperaposte/app/shared/textfield_widget.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);
  @override
  SignupPageState createState() => SignupPageState();
}

class SignupPageState extends ModularState<SignupPage, SignupStore> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController password1 = TextEditingController();
  final TextEditingController password2 = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cpfController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackGroundWidget(),
          TripleBuilder<SignupStore, Exception, UserModel>(
            builder: (_, triple) {
              if (triple.isLoading) {
                return const LoadingWidget();
              }
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      child: Container(
                        alignment: Alignment.topCenter,
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: SingleChildScrollView(
                          physics: const NeverScrollableScrollPhysics(),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Formulário de Cadastro',
                                  style: TextStyle(
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .fontSize,
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
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .fontSize,
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
                                  controller: nameController,
                                  onChanged: (value) {
                                    store.state.name = value;
                                    store.updateForm(store.state);
                                  },
                                  onSaved: (value) {
                                    nameController.text = value as String;
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
                                  controller: addressController,
                                  onSaved: (value) {
                                    addressController.text = value as String;
                                    store.state.address = value;
                                    store.updateForm(store.state);
                                  },
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
                                  height: 10,
                                ),
                                TextFieldWidget(
                                  textInputType: TextInputType.text,
                                  prefixIcon: const Icon(Icons.home),
                                  label: 'CPF',
                                  controller: cpfController,
                                  onSaved: (value) {
                                    cpfController.text = value as String;
                                    store.state.address = value;
                                    store.updateForm(store.state);
                                  },
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
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .fontSize,
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
                                  controller: emailController,
                                  onSaved: (value) {
                                    emailController.text = value as String;
                                    store.state.email = value;
                                    store.updateForm(store.state);
                                  },
                                  onChanged: (value) {
                                    store.state.email = value;
                                    store.updateForm(store.state);
                                  },
                                  validator: (text) {
                                    if (text!.isEmpty ||
                                        !text.contains('@') ||
                                        !text.contains('.')) {
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
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                _formKey.currentState!.save();
                                                await store
                                                    .signup(password1.text)
                                                    .then(
                                                  (value) async {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return const CommomDialog(
                                                          disableCloseButtom:
                                                              true,
                                                          message:
                                                              'Usuário criado com sucesso!',
                                                        );
                                                      },
                                                    );
                                                    await Future.delayed(
                                                      const Duration(
                                                          seconds: 2),
                                                    ).then(
                                                      (value) =>
                                                          Modular.to.pop(),
                                                    );
                                                    Modular.to
                                                        .pushReplacementNamed(
                                                            '/home');
                                                  },
                                                ).catchError(
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
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.1,
            left: MediaQuery.of(context).size.width * 0.05,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const ArrowBackWidget(),
            ),
          ),
        ],
      ),
    );
  }
}
