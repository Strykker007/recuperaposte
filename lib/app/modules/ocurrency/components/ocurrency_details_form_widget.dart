import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:recuperaposte/app/core/models/ocurrency_model.dart';
import 'package:recuperaposte/app/modules/ocurrency/stores/ocurrency_details_store.dart';
import 'package:recuperaposte/app/shared/loading_widget.dart';

class OcurrencyDetailsFormWidget extends StatefulWidget {
  final int protocol;
  const OcurrencyDetailsFormWidget({Key? key, required this.protocol})
      : super(key: key);

  @override
  State<OcurrencyDetailsFormWidget> createState() =>
      _OcurrencyDetailsFormWidgetState();
}

class _OcurrencyDetailsFormWidgetState
    extends ModularState<OcurrencyDetailsFormWidget, OcurrencyDetailsStore> {
  @override
  void initState() {
    store.getOcurrencyByProtocol(widget.protocol);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TripleBuilder<OcurrencyDetailsStore, Exception, OcurrencyModel>(
      builder: (_, triple) {
        if (triple.isLoading) {
          return const LoadingWidget();
        }
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Theme.of(context).primaryColor,
          ),
          padding: const EdgeInsets.all(2),
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    store.state.urlPhoto as String,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'Número da ocorrência: ${store.state.protocol}',
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Theme.of(context).primaryColor),
                ),
                SizedBox(
                  height: 15,
                  child: Divider(
                    color: Theme.of(context).cardColor,
                  ),
                ),
                Text(
                  'descrição: ${store.state.description}',
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Theme.of(context).primaryColor),
                ),
                SizedBox(
                  height: 15,
                  child: Divider(
                    color: Theme.of(context).cardColor,
                  ),
                ),
                Text(
                  'Endereço: ${store.state.address}',
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Theme.of(context).primaryColor),
                ),
                SizedBox(
                  height: 15,
                  child: Divider(
                    color: Theme.of(context).cardColor,
                  ),
                ),
                Text(
                  'Data: ${store.state.date!.substring(0, 10)}',
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Theme.of(context).primaryColor),
                ),
                SizedBox(
                  height: 15,
                  child: Divider(
                    color: Theme.of(context).cardColor,
                  ),
                ),
                Text(
                  'Tipo do Problema: ${store.state.problemType}',
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Theme.of(context).primaryColor),
                ),
                SizedBox(
                  height: 15,
                  child: Divider(
                    color: Theme.of(context).cardColor,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
