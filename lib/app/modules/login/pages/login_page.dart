import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:recuperaposte/app/core/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:recuperaposte/app/shared/background_widget.dart';
import 'package:recuperaposte/app/shared/loading_widget.dart';

import '../components/login_form_widget.dart';
import '../stores/login_store.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends ModularState<LoginPage, LoginStore> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
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
              _buildLoginBody(),
              loading,
            ],
          );
        },
      ),
    );
  }

  Widget _buildLoginBody() {
    return Column(
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(50),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: const LoginFormWidget(),
          ),
        )
      ],
    );
  }
}
