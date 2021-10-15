import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:recuperaposte/app/core/models/user_model.dart';
import 'package:recuperaposte/app/modules/home/components/user_form_widget.dart';
import 'package:recuperaposte/app/modules/home/stores/edit_user_store.dart';
import 'package:recuperaposte/app/shared/background_widget.dart';
import 'package:recuperaposte/app/shared/loading_widget.dart';
import 'package:recuperaposte/app/stores/user_store.dart';

class EditUserPage extends StatefulWidget {
  const EditUserPage({Key? key}) : super(key: key);

  @override
  _EditUserPageState createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  final UserStore userStore = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TripleBuilder<EditUserStore, Exception, UserModel>(
        builder: (_, triple) {
          Widget popup = Container();
          if (triple.isLoading) {
            popup = const LoadingWidget();
          }
          return Stack(
            children: [
              const BackGroundWidget(),
              SafeArea(
                top: true,
                child: Column(
                  children: [
                    Text(
                      'Editar Perfil',
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                            color: Theme.of(context).primaryColor,
                          ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics(),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(vertical: 100),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: UserFormWidget(user: userStore.state),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.1,
                left: MediaQuery.of(context).size.width * 0.05,
                child: GestureDetector(
                  onTap: () {
                    Modular.to.pop();
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_back,
                        color: Theme.of(context).primaryColor,
                      ),
                      Text(
                        'Voltar',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              popup,
            ],
          );
        },
      ),
    );
  }
}
