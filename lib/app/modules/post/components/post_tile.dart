import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:map_launcher/map_launcher.Dart';
import 'package:recuperaposte/app/core/models/post_model.dart';
import 'package:recuperaposte/app/modules/post/components/post_image_dialog_widget.dart';
import 'package:recuperaposte/app/modules/post/stores/manage_post_store.dart';
import 'package:recuperaposte/app/shared/confirm_dialog.dart';

class PostTile extends StatelessWidget {
  final PostModel post;
  const PostTile({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ManagePostStore store = Modular.get();
    return Container(
      height: 160,
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
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                height: MediaQuery.of(context).size.height * 0.11,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nº: ${post.postNumber}',
                            style:
                                Theme.of(context).textTheme.headline6!.copyWith(
                                      fontSize: 16,
                                      color: Theme.of(context).primaryColor,
                                    ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Tipo de Iluminação: ${post.iluminationType.toString()}',
                            style:
                                Theme.of(context).textTheme.headline6!.copyWith(
                                      fontSize: 12,
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Tipo de Poste: ${post.postType.toString()}',
                            style:
                                Theme.of(context).textTheme.headline6!.copyWith(
                                      fontSize: 12,
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return ImagePostDialog(
                                    url: post.urlPhoto as String,
                                  );
                                },
                              );
                            },
                            child: Container(
                              height: 45,
                              width: 45,
                              padding: const EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  post.urlPhoto as String,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              final availableMaps =
                                  await MapLauncher.installedMaps;
                              await availableMaps.last.showMarker(
                                coords: Coords(post.latitude as double,
                                    post.longitude as double),
                                title: post.postNumber.toString(),
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
                          const SizedBox(
                            height: 50,
                          ),
                          IconButton(
                            onPressed: () async {
                              await showDialog(
                                context: context,
                                builder: (context) {
                                  return ConfirmDialog(
                                    message:
                                        'Tem certeza que deseja excluir este poste?',
                                    onConfirm: () async {
                                      store
                                          .deletePost(post.postNumber as String)
                                          .then(
                                        (value) async {
                                          await store.getPosts();

                                          Modular.to.pop();
                                        },
                                      );
                                    },
                                  );
                                },
                              );
                            },
                            icon: const Icon(Icons.close, color: Colors.red),
                          )
                        ],
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
