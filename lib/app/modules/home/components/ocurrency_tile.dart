import 'package:flutter/material.dart';
import 'package:recuperaposte/app/core/models/ocurrency_model.dart';
import 'package:map_launcher/map_launcher.Dart';

class OcurrencyTile extends StatelessWidget {
  final OcurrencyModel ocurrency;
  const OcurrencyTile({
    Key? key,
    required this.ocurrency,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      height: 110,
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
                    ],
                  ),
                ],
              ),
            ),
            // Expanded(
            //   child: Container(
            //       decoration: BoxDecoration(
            //         color: Theme.of(context).primaryColor,
            //         borderRadius: const BorderRadius.only(
            //           bottomLeft: Radius.circular(15),
            //           bottomRight: Radius.circular(15),
            //         ),
            //       ),
            //       child: Text('Minha ocorrencia')),
            // ),
          ],
        ),
      ),
    );
  }
}
