import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:recuperaposte/app/core/models/user_model.dart';
import 'package:recuperaposte/app/modules/login/stores/login_store.dart';
import 'package:recuperaposte/app/shared/background_widget.dart';
import 'package:recuperaposte/app/shared/commom_dialog.dart';
import 'package:recuperaposte/app/shared/common_button_widget.dart';
import 'package:recuperaposte/app/shared/loading_widget.dart';
import 'package:recuperaposte/app/shared/textfield_widget.dart';

class PasswordRecoverPage extends StatefulWidget {
  const PasswordRecoverPage({Key? key}) : super(key: key);

  @override
  _PasswordRecoverPageState createState() => _PasswordRecoverPageState();
}

class _PasswordRecoverPageState extends State<PasswordRecoverPage> {
  TextEditingController emailTextController = TextEditingController();
  final LoginStore store = Modular.get();
  final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TripleBuilder<LoginStore, Exception, UserModel>(
        store: store,
        builder: (_, triple) {
          Widget loading = Container();

          if (triple.isLoading) {
            loading = const LoadingWidget();
          }
          return Stack(
            children: [
              const BackGroundWidget(),
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
                              'Digite seu e-mail, enviaremos uma solicita????o para a troca de sua senha:',
                              textAlign: TextAlign.center,
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
                            Form(
                              key: _formKey,
                              child: TextFieldWidget(
                                controller: emailTextController,
                                textInputType: TextInputType.emailAddress,
                                prefixIcon: const Icon(Icons.home),
                                label: 'E-mail',
                                onSaved: (email) {
                                  emailTextController.text = email.toString();
                                },
                                validator: (text) {
                                  if (text!.isEmpty ||
                                      !text.contains('@') ||
                                      !text.contains('.')) {
                                    return 'E-mail inv??lido';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            TripleBuilder<LoginStore, Exception, UserModel>(
                              builder: (_, triple) {
                                return CommonButtonWidget(
                                  onTap: () async {
                                    if (_formKey.currentState!.validate()) {
                                      store
                                          .passwordRecovery(
                                              emailTextController.text)
                                          .then(
                                        (value) async {
                                          showDialog(
                                            context: context,
                                            builder: (_) {
                                              return const CommomDialog(
                                                  message:
                                                      'Solicita????o enviada com sucesso, por favor verifique seu e-mail!');
                                            },
                                          );
                                        },
                                      ).catchError((onError) {
                                        showDialog(
                                          context: context,
                                          builder: (_) {
                                            return const CommomDialog(
                                                message:
                                                    'Erro ao realizar a solicita????o, por favor verifique se o e-mail informado est?? correto!');
                                          },
                                        );
                                      });
                                    }
                                  },
                                  label: 'Recuperar Senha',
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              loading
            ],
          );
        },
      ),
    );
  }
}
