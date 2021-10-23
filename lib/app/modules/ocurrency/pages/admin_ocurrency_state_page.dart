import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:recuperaposte/app/core/models/ocurrency_model.dart';
import 'package:recuperaposte/app/modules/home/stores/search_textfield_store.dart';
import 'package:recuperaposte/app/modules/ocurrency/components/manage_ocurrency_tile.dart';
import 'package:recuperaposte/app/modules/ocurrency/stores/ocurrency_manager_status_store.dart';
import 'package:recuperaposte/app/shared/arrow_back_widget.dart';
import 'package:recuperaposte/app/shared/background_widget.dart';
import 'package:recuperaposte/app/shared/loading_widget.dart';
import 'package:recuperaposte/app/shared/textfield_widget.dart';

class AdminOcurrencyStatusPage extends StatefulWidget {
  const AdminOcurrencyStatusPage({Key? key}) : super(key: key);

  @override
  _AdminOcurrencyStatusPageState createState() =>
      _AdminOcurrencyStatusPageState();
}

class _AdminOcurrencyStatusPageState extends ModularState<
    AdminOcurrencyStatusPage, OcurrencyManagerStatusStore> {
  final TextEditingController searchController =
      TextEditingController(text: '');
  final SearchTextFieldStore textFieldStore = Modular.get();
  FocusNode textFocus = FocusNode();
  @override
  void initState() {
    textFieldStore.update('');
    store.getOcurrencies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TripleBuilder<OcurrencyManagerStatusStore, Exception,
          List<OcurrencyModel>>(
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
                    margin: const EdgeInsets.only(
                      top: 50,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Gerenciar Ocorrências',
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    color: Theme.of(context).primaryColor,
                                  ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TripleBuilder<SearchTextFieldStore, Exception, String>(
                          builder: (_, triple) {
                            return Container(
                              margin: const EdgeInsets.all(15),
                              child: Column(
                                children: [
                                  TextFieldWidget(
                                    focusNode: textFocus,
                                    label: 'Pesquisar',
                                    hintText: 'Digite o número do protocolo',
                                    controller: searchController,
                                    onChanged: (value) async {
                                      if (value!.isEmpty) {
                                        searchController.text = '';
                                        await store.getOcurrencies();
                                        textFieldStore.update('');
                                        textFocus.unfocus();
                                      }
                                    },
                                    suffixIcon: IconButton(
                                      icon: textFieldStore.state.isEmpty
                                          ? const Icon(Icons.search)
                                          : const Icon(Icons.close),
                                      onPressed: textFieldStore.state.isEmpty
                                          ? searchByProtocol
                                          : searchAllOcurrencies,
                                    ),
                                  ),
                                  const Divider(color: Colors.black),
                                ],
                              ),
                            );
                          },
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
                              return ManageOcurrencyTile(
                                queryparam: searchController.text,
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

  void searchByProtocol() async {
    textFieldStore.update(searchController.text);
    if (textFieldStore.state.isNotEmpty) {
      await store.getFilteredOcurrencies(
        textFieldStore.state,
      );
    } else {
      await store.getOcurrencies();
    }
    searchController.text = textFieldStore.state;
    textFocus.unfocus();
  }

  void searchAllOcurrencies() async {
    searchController.text = '';
    await store.getOcurrencies();
    textFieldStore.update('');
    textFocus.unfocus();
  }
}
