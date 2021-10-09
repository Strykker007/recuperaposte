import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:recuperaposte/app/core/models/user_model.dart';
import 'package:recuperaposte/app/modules/login/stores/login_store.dart';

class CustomDrawer extends StatefulWidget {
  final UserModel user;
  final Function? signout;
  const CustomDrawer({Key? key, required this.user, required this.signout})
      : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final LoginStore store = Modular.get();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: ClipOval(
              child: Image.asset("assets/imagens/logo.png"),
            ),
            accountName: Text(widget.user.name.toString()),
            accountEmail: Text(widget.user.email.toString()),
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
                Navigator.of(context).pushReplacementNamed('/home/login');
              });
            },
          ),
        ],
      ),
    );
  }
}
