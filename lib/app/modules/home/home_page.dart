import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'home_store.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, this.title = "Pagina Inicial"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: ClipOval(
                child: Image.asset("assets/imagens/logo.png"),
              ),
              accountName: const Text('Usuario'),
              accountEmail: const Text('email@hotmail.com'),
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
              onTap: () {
                Navigator.of(context).pushNamed('/login');
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Pagina Inicial'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          store.increment();
        },
        child: Icon(
          Icons.add,
          color: Theme.of(context).backgroundColor,
        ),
      ),
    );
  }
}
