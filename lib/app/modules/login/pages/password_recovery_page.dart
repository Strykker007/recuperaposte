import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:recuperaposte/app/core/models/user_model.dart';
import 'package:recuperaposte/app/modules/login/login_store.dart';
import 'package:recuperaposte/app/shared/common_button_widget.dart';
import 'package:recuperaposte/app/shared/loading_widget.dart';
import 'package:recuperaposte/app/shared/textfield_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PasswordRecoverPage extends StatefulWidget {
  const PasswordRecoverPage({Key? key}) : super(key: key);

  @override
  _PasswordRecoverPageState createState() => _PasswordRecoverPageState();
}

class _PasswordRecoverPageState extends State<PasswordRecoverPage> {
  TextEditingController editController = TextEditingController();
  Widget loading = Container();
  final LoginStore store = Modular.get();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TripleBuilder<LoginStore, Exception, UserModel>(
          store: store,
          builder: (_, triple) {
            if (triple.isLoading) {
              loading = const LoadingWidget();
            }
            return Stack(
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
                    onTap: () {
                      Navigator.of(context).pop();
                    },
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
                Column(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(50),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: SingleChildScrollView(
                          physics: const NeverScrollableScrollPhysics(),
                          child: Form(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Esqueceu a sua senha?',
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
                                  'Digite seu e-mail, enviaremos uma solicitação para a troca de sua senha:',
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
                                  controller: editController,
                                  textInputType: TextInputType.emailAddress,
                                  prefixIcon: const Icon(Icons.home),
                                  label: 'E-mail',
                                  onChanged: (value) {},
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
                                  height: 15,
                                ),
                                TripleBuilder<LoginStore, Exception, UserModel>(
                                  builder: (_, triple) {
                                    return CommonButtonWidget(
                                      onTap: store.isLoading
                                          ? null
                                          : () async {
                                              FirebaseAuth.instance
                                                  .sendPasswordResetEmail(
                                                      email:
                                                          editController.text)
                                                  .then((value) {
                                                Fluttertoast.showToast(
                                                    msg: "E-mail enviando",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    timeInSecForIosWeb: 2,
                                                    backgroundColor:
                                                        Colors.blue,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0);
                                              });

                                              Navigator.of(context).pop();

                                              await store.login();
                                            },
                                      label: 'Enviar ao E-mail',
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }),
    );
  }
}
