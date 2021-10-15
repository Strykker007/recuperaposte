import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:recuperaposte/app/core/models/ocurrency_model.dart';
import 'package:recuperaposte/app/core/models/user_model.dart';
import 'package:recuperaposte/app/modules/home/components/manage_user_tile_widget.dart';
import 'package:recuperaposte/app/modules/home/stores/search_textfield_store.dart';
import 'package:recuperaposte/app/modules/home/stores/user_manager_store.dart';
import 'package:recuperaposte/app/modules/ocurrency/components/manage_ocurrency_tile.dart';
import 'package:recuperaposte/app/modules/ocurrency/stores/ocurrency_manager_status_store.dart';
import 'package:recuperaposte/app/shared/arrow_back_widget.dart';
import 'package:recuperaposte/app/shared/background_widget.dart';
import 'package:recuperaposte/app/shared/confirm_dialog.dart';
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
  @override
  void initState() {
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
                                    label: 'Pesquisar',
                                    hintText: 'Digite o número do protocolo',
                                    controller: searchController,
                                    // suffixIcon: IconButton(
                                    //   icon: textFieldStore.state.isEmpty
                                    //       ? const Icon(Icons.search)
                                    //       : const Icon(Icons.close),
                                    //   onPressed: textFieldStore.state.isEmpty
                                    //       ? searchByText
                                    //       : searchAllUsers,
                                    // ),
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
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics(),
                            ),
                            child: RefreshIndicator(
                              onRefresh: () async {},
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: store.state.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      // showDialog(
                                      //   context: context,
                                      //   builder: (context) {
                                      //     return ConfirmDialog(
                                      //       message: store
                                      //                   .state[index].isAdmin ==
                                      //               true
                                      //           ? 'Tem certeza que deseja remover os privilégios desse usuário?'
                                      //           : 'Tem certeza que deseja tornar esse usuário um administrador?',
                                      //       onConfirm: () async {
                                      //         await store
                                      //             .updateUser(
                                      //           store.state[index],
                                      //         )
                                      //             .then((value) {
                                      //           textFieldStore.state.isEmpty
                                      //               ? searchByText
                                      //               : searchAllUsers;
                                      //           Modular.to.pop();
                                      //         });
                                      //       },
                                      //     );
                                      //   },
                                      // );
                                    },
                                    child: ManageOcurrencyTile(
                                      ocurrency: store.state[index],
                                    ),
                                  );
                                },
                              ),
                            ),
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

  // void searchByText() async {
  //   textFieldStore.update(searchController.text);
  //   if (textFieldStore.state.isNotEmpty) {
  //     await store.getFilteredUsers(
  //       textFieldStore.state,
  //     );
  //   } else {
  //     await store.getUsers();
  //   }
  //   searchController.text = textFieldStore.state;
  // }

  // void searchAllUsers() async {
  //   searchController.text = '';
  //   await store.getUsers();
  //   textFieldStore.update('');
  // }
}
