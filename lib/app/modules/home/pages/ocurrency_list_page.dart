import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:recuperaposte/app/core/models/ocurrency_model.dart';
import 'package:recuperaposte/app/modules/home/components/ocurrency_tile.dart';
import 'package:recuperaposte/app/modules/home/stores/ocurrency_list_store.dart';
import 'package:recuperaposte/app/modules/home/stores/search_textfield_store.dart';
import 'package:recuperaposte/app/shared/arrow_back_widget.dart';
import 'package:recuperaposte/app/shared/background_widget.dart';
import 'package:recuperaposte/app/shared/loading_widget.dart';

class OcurrencyListPage extends StatefulWidget {
  const OcurrencyListPage({Key? key}) : super(key: key);

  @override
  _OcurrencyListPageState createState() => _OcurrencyListPageState();
}

class _OcurrencyListPageState
    extends ModularState<OcurrencyListPage, OcurrencyListStore> {
  final SearchTextFieldStore textFieldStore = Modular.get();
  FocusNode textFocus = FocusNode();
  @override
  void initState() {
    store.getOcurrencies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TripleBuilder<OcurrencyListStore, Exception, List<OcurrencyModel>>(
        builder: (_, triple) {
          Widget loading = Container();
          if (triple.isLoading) {
            loading = const Center(child: LoadingWidget());
          }
          return Stack(
            children: [
              const BackGroundWidget(),
              const Positioned(
                top: 90,
                left: 20,
                child: ArrowBackWidget(),
              ),
              Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(
                      top: 50,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Consultar Ocorrências',
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    color: Theme.of(context).primaryColor,
                                  ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                  triple.state.isEmpty
                      ? Text(
                          'Nenhum resultado encontrado!',
                          style: Theme.of(context).textTheme.headline6,
                        )
                      : Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: store.state.length,
                            itemBuilder: (context, index) {
                              return OcurrencyTile(
                                ocurrency: store.state[index],
                              );
                            },
                          ),
                        ),
                ],
              ),
              loading,
            ],
          );
        },
      ),
    );
  }
}
