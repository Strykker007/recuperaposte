import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:recuperaposte/app/core/models/ocurrency_model.dart';
import 'package:recuperaposte/app/modules/ocurrency/stores/ocurrency_details_store.dart';
import 'package:recuperaposte/app/modules/ocurrency/stores/ocurrency_manager_status_store.dart';
import 'package:recuperaposte/app/shared/confirm_dialog.dart';
import 'package:map_launcher/map_launcher.Dart';

class ManageOcurrencyTile extends StatelessWidget {
  final String queryparam;
  final OcurrencyModel ocurrency;
  const ManageOcurrencyTile(
      {Key? key, required this.ocurrency, required this.queryparam})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final OcurrencyManagerStatusStore store = Modular.get();
    final OcurrencyDetailsStore detailsStore = Modular.get();
    String status = '';

    if (ocurrency.status == 1) {
      status = 'Aberto';
    }
    if (ocurrency.status == 2) {
      status = 'Em andamento';
    }
    if (ocurrency.status == 3) {
      status = 'Concluído';
    }
    if (ocurrency.status == 4) {
      status = 'Cancelado';
    }

    return Container(
      height: 140,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Theme.of(context).primaryColor,
      ),
      child: Container(
        margin: const EdgeInsets.all(2),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Theme.of(context).backgroundColor,
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              height: MediaQuery.of(context).size.height * 0.11,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nº: ${ocurrency.protocol}',
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontSize: 16,
                              color: Theme.of(context).primaryColor,
                            ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.height * 0.03,
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics(),
                          ),
                          scrollDirection: Axis.vertical,
                          child: Text(
                            'Descrição: ${ocurrency.description.toString()}',
                            style:
                                Theme.of(context).textTheme.headline6!.copyWith(
                                      fontSize: 12,
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ),
                      ),
                      Text(
                        status,
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontSize: 16,
                              color: ocurrency.status == 4
                                  ? Colors.red
                                  : ocurrency.status == 3
                                      ? Colors.green
                                      : ocurrency.status == 2
                                          ? Colors.yellow
                                          : Colors.grey,
                            ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          final availableMaps = await MapLauncher.installedMaps;
                          await availableMaps.last.showMarker(
                            coords: Coords(ocurrency.latitude as double,
                                ocurrency.longitude as double),
                            title: ocurrency.address.toString(),
                          );
                        },
                        child: Row(
                          children: const [
                            Text('Localização'),
                            SizedBox(
                              width: 3,
                            ),
                            Icon(
                              Icons.map,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () async {
                              if (ocurrency.urgency == 'Alta') {
                                ocurrency.urgency = 'Média';
                                await store.updateUrgency(ocurrency);
                              } else if (ocurrency.urgency == 'Média') {
                                ocurrency.urgency = 'Baixa';
                                await store.updateUrgency(ocurrency);
                              }
                            },
                            icon: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Theme.of(context).primaryColor,
                              ),
                              padding: const EdgeInsets.all(2),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white,
                                ),
                                child: const Icon(
                                  Icons.arrow_left,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            ocurrency.urgency.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(
                                    color: Theme.of(context).primaryColor),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (ocurrency.urgency == 'Baixa') {
                                ocurrency.urgency = 'Média';
                                await store.updateUrgency(ocurrency);
                              } else if (ocurrency.urgency == 'Média') {
                                ocurrency.urgency = 'Alta';
                                await store.updateUrgency(ocurrency);
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Theme.of(context).primaryColor,
                              ),
                              padding: const EdgeInsets.all(2),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white,
                                ),
                                child: const Icon(
                                  Icons.arrow_right,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () async {
                        await detailsStore
                            .getOcurrencyByProtocol(ocurrency.protocol as int)
                            .then(
                          (value) {
                            Modular.to.pushNamed(
                              '/home/ocurrency/ocurrenyDetails',
                              arguments: detailsStore.state,
                            );
                          },
                        );
                      },
                      child: Text(
                        'Detalhes',
                        style: TextStyle(
                          color: Theme.of(context).backgroundColor,
                        ),
                      ),
                    ),
                    VerticalDivider(
                      color: Theme.of(context).backgroundColor,
                    ),
                    TextButton(
                      onPressed: (ocurrency.status as int >= 1 &&
                              ocurrency.status as int < 3
                          ? () async {
                              await showDialog(
                                context: context,
                                builder: (context) {
                                  return ConfirmDialog(
                                    message:
                                        'Tem certeza que deseja alterar o status dessa ocorrência?',
                                    onConfirm: () async {
                                      store
                                          .updateOcurrency(ocurrency, 'next')
                                          .then(
                                        (value) async {
                                          if (queryparam.isEmpty) {
                                            if (queryparam.isNotEmpty) {
                                              await store
                                                  .getFilteredOcurrencies(
                                                queryparam,
                                              );
                                            } else {
                                              await store.getOcurrencies();
                                            }
                                          } else {
                                            await store.getOcurrencies();
                                          }
                                          Modular.to.pop();
                                        },
                                      );
                                    },
                                  );
                                },
                              );
                            }
                          : null),
                      child: const Text(
                        'Avançar',
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                    VerticalDivider(color: Theme.of(context).backgroundColor),
                    TextButton(
                      onPressed: ocurrency.status as int != 4
                          ? () async {
                              await showDialog(
                                context: context,
                                builder: (context) {
                                  return ConfirmDialog(
                                    message:
                                        'Tem certeza que deseja cancelar essa ocorrência?',
                                    onConfirm: () async {
                                      store
                                          .updateOcurrency(ocurrency, 'cancel')
                                          .then(
                                        (value) async {
                                          if (queryparam.isEmpty) {
                                            if (queryparam.isNotEmpty) {
                                              await store
                                                  .getFilteredOcurrencies(
                                                queryparam,
                                              );
                                            } else {
                                              await store.getOcurrencies();
                                            }
                                          } else {
                                            await store.getOcurrencies();
                                          }
                                          Modular.to.pop();
                                        },
                                      );
                                    },
                                  );
                                },
                              );
                            }
                          : null,
                      child: Text(
                        'Cancelar',
                        style: TextStyle(
                          color: Theme.of(context).errorColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
