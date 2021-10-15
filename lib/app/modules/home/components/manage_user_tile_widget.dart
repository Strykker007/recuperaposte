import 'package:flutter/material.dart';
import 'package:recuperaposte/app/core/models/user_model.dart';

class ManageUserTile extends StatelessWidget {
  final UserModel user;
  const ManageUserTile({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Theme.of(context).primaryColor,
      ),
      child: Container(
        margin: const EdgeInsets.all(3),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Theme.of(context).backgroundColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  user.name.toString(),
                  style: Theme.of(context).textTheme.headline6,
                ),
                user.isAdmin == true
                    ? Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.green,
                        ),
                        child: Container(
                          margin: const EdgeInsets.all(2),
                          padding: const EdgeInsets.symmetric(
                              vertical: 1, horizontal: 3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.white,
                          ),
                          child: const Text('Admin'),
                        ),
                      )
                    : Container()
              ],
            ),
            Text(
              user.email.toString(),
              style:
                  Theme.of(context).textTheme.headline6!.copyWith(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
