import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:recuperaposte/app/modules/home/stores/edit_user_image_picked_store.dart';
import 'dart:io';

class EditUserImagePickedCardWidget extends StatelessWidget {
  final File file;
  const EditUserImagePickedCardWidget({
    Key? key,
    required this.file,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final EditUserImagePickerStore imagePickerStore = Modular.get();
    return Stack(
      children: [
        Container(
          height: 170,
          width: 170,
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(15)),
          child: file.path.isNotEmpty
              ? ClipRRect(
                  child: Image.file(
                    file,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(15),
                )
              : ClipRRect(
                  child: Image.asset(
                    'assets/imagens/empty-photo.jpg',
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
        ),
        Positioned(
          right: 5,
          child: GestureDetector(
            onTap: file.path.length > 1
                ? () {
                    imagePickerStore.update(
                      File(''),
                    );
                  }
                : null,
            child: file.path.length > 1
                ? Align(
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          width: 2,
                          color: Colors.black,
                        ),
                      ),
                      child: const Icon(
                        Icons.cancel,
                        color: Colors.black,
                      ),
                    ),
                  )
                : Align(
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          width: 2,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
          ),
        )
      ],
    );
  }
}
