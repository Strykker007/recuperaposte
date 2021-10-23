import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:recuperaposte/app/core/models/ocurrency_model.dart';
import 'package:recuperaposte/app/modules/ocurrency/components/ocurrency_details_form_widget.dart';
import 'package:recuperaposte/app/modules/ocurrency/stores/ocurrency_details_store.dart';
import 'package:recuperaposte/app/shared/arrow_back_widget.dart';
import 'package:recuperaposte/app/shared/background_widget.dart';
import 'package:recuperaposte/app/shared/loading_widget.dart';

class OcurrencyDetailsPage extends StatefulWidget {
  final OcurrencyModel ocurrency;
  const OcurrencyDetailsPage({Key? key, required this.ocurrency})
      : super(key: key);

  @override
  _OcurrencyDetailsPageState createState() => _OcurrencyDetailsPageState();
}

class _OcurrencyDetailsPageState extends State<OcurrencyDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TripleBuilder<OcurrencyDetailsStore, Exception, OcurrencyModel>(
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
              Container(
                alignment: Alignment.topCenter,
                margin: const EdgeInsets.only(top: 50),
                child: Column(
                  children: [
                    Text(
                      'Detalhes da ocorrência',
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                            color: Theme.of(context).primaryColor,
                          ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      margin: const EdgeInsets.all(15),
                      child: OcurrencyDetailsFormWidget(
                        protocol: widget.ocurrency.protocol as int,
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
