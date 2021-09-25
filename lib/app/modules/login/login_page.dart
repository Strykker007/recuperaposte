import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:recuperaposte/app/models/user_model.dart';
import 'package:recuperaposte/app/modules/login/login_store.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final String title;
  const LoginPage({Key? key, this.title = 'LoginPage'}) : super(key: key);
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends ModularState<LoginPage, LoginStore> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(
            color: Theme.of(context).textTheme.headline1!.color,
          ),
        ),
      ),
      body: Column(
        children: [
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
                      decoration: const InputDecoration(hintText: 'Usuário'),
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
                      decoration: const InputDecoration(hintText: 'senha'),
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
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
