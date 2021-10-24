import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:recuperaposte/app/core/models/user_model.dart';
import 'package:recuperaposte/app/modules/home/stores/quantity_ocurrency_home_card_store.dart';
import 'package:recuperaposte/app/modules/login/stores/login_store.dart';
import 'package:recuperaposte/app/shared/background_widget.dart';
import 'package:recuperaposte/app/shared/custom_drawer.dart';
import 'components/home_header_widget.dart';
import 'components/ocurrency_card_widget.dart';
import 'stores/home_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeStore> {
  LoginStore loginStore = Modular.get();
  final QuantityOcurrencyHomeCardStore ocurrencyStore = Modular.get();
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void initState() {
    ocurrencyStore.getQuantityOcurrencies();
    super.initState();
  }

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
          const BackGroundWidget(),
          RefreshIndicator(
            onRefresh: () async {
              await ocurrencyStore.getQuantityOcurrencies();
            },
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                HomeHeaderWidget(scaffoldKey: _key),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Modular.to.pushNamed('/home/ocurrencyList');
                            },
                            child: const OcurrencyCardWidget(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
