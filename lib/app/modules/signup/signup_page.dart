import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:recuperaposte/app/models/user_model.dart';
import 'package:recuperaposte/app/modules/login/login_store.dart';
import 'package:recuperaposte/app/modules/signup/signup_store.dart';
import 'package:recuperaposte/app/shared/common_button_widget.dart';
import 'package:recuperaposte/app/shared/textfield_widget.dart';

import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);
  @override
  SignupPageState createState() => SignupPageState();
}

class SignupPageState extends ModularState<SignupPage, SignupStore> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              'assets/imagens/background_login.png',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.1),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.1,
            left: MediaQuery.of(context).size.width * 0.05,
            child: GestureDetector(
              onTap: () {},
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).primaryColor,
                  ),
                  Text(
                    'Voltar',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  )
                ],
              ),
            ),
          ),
          _buildLoginBody(),
        ],
      ),
    );
  }

  Widget _buildLoginBody() {
    return Column(
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.symmetric(horizontal: 50),
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
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
                        fontSize:
                            Theme.of(context).textTheme.headline6!.fontSize,
                        color: Theme.of(context).primaryColor,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFieldWidget(
                      textInputType: TextInputType.emailAddress,
                      prefixIcon: const Icon(Icons.login),
                      label: 'Usuário',
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
                      obscureText: true,
                      prefixIcon: const Icon(Icons.lock),
                      label: 'Senha',
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
                    TripleBuilder<LoginStore, Exception, UserModel>(
                      builder: (_, triple) {
                        return CommonButtonWidget(
                          onTap: store.isLoading
                              ? null
                              : () async {
                                  if (_formKey.currentState!.validate()) {
                                    await store.signup();
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
        )
      ],
    );
  }
}
