import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:recuperaposte/app/core/models/user_model.dart';
import 'package:recuperaposte/app/modules/login/login_store.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final LoginStore store = Modular.get<LoginStore>();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          TripleBuilder<LoginStore, Exception, UserModel>(
            builder: (_, triple) {
              return UserAccountsDrawerHeader(
                currentAccountPicture: ClipOval(
                  child: Image.asset("assets/imagens/logo.png"),
                ),
                accountName: Text(triple.state.name.toString()),
                accountEmail: Text(triple.state.email.toString()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Inicio'),
            subtitle: const Text('Tela de Inicio'),
            onTap: () {
              // ignore: avoid_print
              print('home');
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_alert_rounded),
            title: const Text('Registrar Ocorrencia'),
            subtitle: const Text('Fazer a Ocorrencia'),
            onTap: () {
              Navigator.of(context).pushNamed('');
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_alert),
            title: const Text('Status Ocorrencia'),
            subtitle: const Text('Status das Ocorrencias'),
            onTap: () {
              Navigator.of(context).pushNamed('');
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_alert_rounded),
            title: const Text('Atendimeto de Ocorrencia'),
            subtitle: const Text('Atender/Validar Ocorrencias'),
            onTap: () {
              Navigator.of(context).pushNamed('');
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            subtitle: const Text('Sair da Sessão'),
            onTap: () async {
              await store.logout().then((value) {
                Navigator.of(context).popUntil(ModalRoute.withName('/login/'));
              });
            },
          ),
        ],
      ),
    );
  }
}
