import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:recuperaposte/app/modules/post/stores/post_store.dart';
import 'package:recuperaposte/app/shared/arrow_back_widget.dart';
import 'package:recuperaposte/app/shared/background_widget.dart';

import 'components/post_form_widget.dart';

class PostPage extends StatefulWidget {
  final String title;
  const PostPage({Key? key, this.title = 'PostPage'}) : super(key: key);
  @override
  PostPageState createState() => PostPageState();
}

class PostPageState extends State<PostPage> {
  final PostStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
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
              children: const [
                ArrowBackWidget(),
              ],
            ),
          ),
        ),
        SafeArea(
          top: true,
          child: Container(
            margin: const EdgeInsets.only(top: 80),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    child: Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(15),
                          child: const PostFormWidget(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
