import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:recuperaposte/app/core/models/user_model.dart';
import 'package:recuperaposte/app/modules/login/stores/login_store.dart';
import 'package:recuperaposte/app/stores/user_store.dart';

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
  final UserStore userStore = Modular.get();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Stack(
            children: [
              UserAccountsDrawerHeader(
                currentAccountPicture: ClipOval(
                  child: userStore.state.avatarUrl != null
                      ? Image.network(
                          userStore.state.avatarUrl.toString(),
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          "assets/imagens/profile.png",
                          fit: BoxFit.cover,
                        ),
                ),
                accountName: Text('Olá, ${userStore.state.name.toString()}'),
                accountEmail: Text(userStore.state.email.toString()),
              ),
              Positioned(
                bottom: 10,
                right: 5,
                child: IconButton(
                  iconSize: 24,
                  color: Theme.of(context).backgroundColor,
                  onPressed: () async {
                    Modular.to.pop();
                    await Future.delayed(const Duration(milliseconds: 40));
                    Modular.to.pushNamed('/home/edituser');
                  },
                  icon: const Icon(Icons.manage_accounts),
                ),
              ),
            ],
          ),
          ListTile(
            leading: const Icon(Icons.add_alert_rounded),
            title: const Text('Registrar Ocorrencia'),
            subtitle: const Text('Registrar uma nova ocorrencia'),
            onTap: () async {
              Modular.to.pop();
              Modular.to.pushNamed('/home/ocurrency');
              await Future.delayed(const Duration(milliseconds: 40));
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Sair'),
            subtitle: const Text('Encerrar Sessão'),
            onTap: () async {
              await store.logout().then((value) async {
                Modular.to.pop();
                await Future.delayed(const Duration(milliseconds: 40));
                Modular.to.pushReplacementNamed('/');
              });
            },
          ),
          userStore.state.isAdmin == true
              ? Column(
                  children: [
                    Divider(height: 2, color: Theme.of(context).primaryColor),
                    ListTile(
                      leading: const Icon(Icons.admin_panel_settings),
                      title: const Text('Gerenciar usuários'),
                      subtitle: const Text('Administrar premissões'),
                      onTap: () async {
                        Modular.to.pop();
                        await Future.delayed(const Duration(milliseconds: 40));
                        Modular.to.pushNamed('/home/userManager');
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.list),
                      title: const Text('Ocorrências'),
                      subtitle: const Text('Consultar ocorrências'),
                      onTap: () async {
                        Modular.to.pop();
                        await Future.delayed(const Duration(milliseconds: 40));
                        Modular.to.pushNamed('/home/ocurrency/manageOcurrency');
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.light),
                      title: const Text('Cadastrar Poste'),
                      subtitle: const Text('Cadastro de postes'),
                      onTap: () async {
                        Modular.to.pop();
                        await Future.delayed(const Duration(milliseconds: 40));
                        Modular.to.pushNamed('/home/createPost');
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.manage_search),
                      title: const Text('Consultar Postes'),
                      subtitle: const Text('Gestão de postes'),
                      onTap: () async {
                        Modular.to.pop();
                        await Future.delayed(const Duration(milliseconds: 40));
                        Modular.to.pushNamed('/home/createPost/managePost');
                      },
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}
