import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:recuperaposte/app/core/models/ocurrency_model.dart';
import 'package:recuperaposte/app/modules/ocurrency/components/ocurrency_form_widget.dart';
import 'package:recuperaposte/app/modules/ocurrency/ocurrency_store.dart';
import 'package:flutter/material.dart';
import 'package:recuperaposte/app/shared/background_widget.dart';
import 'package:recuperaposte/app/shared/loading_widget.dart';

class OcurrencyPage extends StatefulWidget {
  final String title;
  const OcurrencyPage({Key? key, this.title = 'OcurrencyPage'})
      : super(key: key);
  @override
  OcurrencyPageState createState() => OcurrencyPageState();
}

class OcurrencyPageState extends State<OcurrencyPage> {
  final OcurrencyStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TripleBuilder<OcurrencyStore, Exception, OcurrencyModel>(
        builder: (_, triple) {
          Widget loading = Container();
          if (triple.isLoading) {
            loading = const Center(child: LoadingWidget());
          }
          return Stack(
            children: [
              const BackGroundWidget(),
              Positioned(
                top: 90,
                left: 20,
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
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontSize: 15,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Registrar ocorrência',
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                            color: Theme.of(context).primaryColor,
                          ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        child: Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.all(15),
                              child: const OcurrencyFormWidget(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              loading,
            ],
          );
        },
      ),
    );
  }
}
