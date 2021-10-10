import 'package:flutter_modular/flutter_modular.dart';
import 'package:recuperaposte/app/modules/ocurrency/components/ocurrency_form_widget.dart';
import 'package:recuperaposte/app/modules/ocurrency/ocurrency_store.dart';
import 'package:flutter/material.dart';
import 'package:recuperaposte/app/shared/background_widget.dart';

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
        body: Stack(
      children: [
        const BackGroundWidget(),
        SafeArea(
          top: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
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
      ],
    ));
  }
}
