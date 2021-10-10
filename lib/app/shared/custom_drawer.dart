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
          Stack(
            children: [
              UserAccountsDrawerHeader(
                currentAccountPicture: ClipOval(
                  child: widget.user.avatarUrl != null
                      ? Image.network(widget.user.avatarUrl.toString())
                      : Image.asset("assets/imagens/profile.png"),
                ),
                accountName: Text('Olá, ${widget.user.name.toString()}'),
                accountEmail: Text(widget.user.email.toString()),
              ),
              Positioned(
                bottom: 10,
                right: 5,
                child: Stack(
                  children: [
                    Positioned(
                      top: 9,
                      right: 7,
                      child: Icon(
                        Icons.settings,
                        size: 13,
                        color: Theme.of(context).backgroundColor,
                      ),
                    ),
                    IconButton(
                      iconSize: 24,
                      color: Theme.of(context).backgroundColor,
                      onPressed: () {},
                      icon: const Icon(Icons.person),
                    ),
                  ],
                ),
              ),
            ],
          ),
          ListTile(
            leading: const Icon(Icons.add_alert_rounded),
            title: const Text('Registrar Ocorrencia'),
            subtitle: const Text('Registrar uma nova ocorrencia'),
            onTap: () {
              Navigator.of(context).pushNamed('/home/ocurrency');
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
            title: const Text('Sair'),
            subtitle: const Text('Encerrar Sessão'),
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
