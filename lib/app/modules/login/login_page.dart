import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:recuperaposte/app/models/user_model.dart';
import 'package:recuperaposte/app/modules/login/login_store.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final String title;
  const LoginPage({Key? key, this.title = 'Tela de Login'}) : super(key: key);
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends ModularState<LoginPage, LoginStore> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  Widget _body() {
    return Column(
      children: [
        /*Container(
            width: 200,
            height: 200,
            child: Image.asset('assets/imagens/logo.png'),
            ),*/
        Expanded(
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(50),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    autofocus: true,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.login),
                      labelText: 'Usuário',
                    ),
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
                  TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                      labelText: 'Senha',
                    ),
                    validator: (text) {
                      if (text!.isEmpty) {
                        return 'Este campo não pode ser vazio';
                      } else {
                        return null;
                      }
                    },
                  ),
                  Container(
                    height: 40,
                    alignment: Alignment.centerRight,
                    // ignore: deprecated_member_use
                    child: FlatButton(
                      child: const Text(
                        'Recuperar Senha',
                      ),
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TripleBuilder<LoginStore, Exception, UserModel>(
                    builder: (_, triple) {
                      return GestureDetector(
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          width: 170,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: store.isLoading
                              ? CircularProgressIndicator(
                                  color: Theme.of(context).backgroundColor)
                              : const Text('Login'),
                        ),
                        onTap: store.isLoading
                            ? null
                            : () async {
                                if (_formKey.currentState!.validate()) {
                                  await store.login();
                                }
                              },
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TripleBuilder<LoginStore, Exception, UserModel>(
                    builder: (_, triple) {
                      return GestureDetector(
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          width: 170,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: store.isLoading
                              ? CircularProgressIndicator(
                                  color: Theme.of(context).backgroundColor)
                              : const Text('Cadastrar'),
                        ),
                        onTap: store.isLoading
                            ? null
                            : () async {
                                await store.registration();
                              },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
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
          _body(),
        ],
      ),
    );
  }
}
