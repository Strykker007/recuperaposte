import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:recuperaposte/app/core/models/user_model.dart';
import 'package:recuperaposte/app/modules/login/stores/login_store.dart';
import 'package:recuperaposte/app/shared/custom_drawer.dart';
import 'home_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeStore> {
  LoginStore loginStore = Modular.get();
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: TripleBuilder<LoginStore, Exception, UserModel>(
        builder: (_, triple) {
          return CustomDrawer(
            user: loginStore.state,
            signout: () {
              loginStore.logout().then((value) =>
                  Navigator.of(context).pushReplacementNamed('/login/'));
            },
          );
        },
      ),
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
          Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.14,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                    ),
                    child: IconButton(
                      onPressed: () {
                        _key.currentState!.openDrawer();
                      },
                      icon: const Icon(Icons.menu),
                    ),
                  ),
                ],
              ),
              Expanded(child: Container())
            ],
          ),
        ],
      ),
    );
  }
}
