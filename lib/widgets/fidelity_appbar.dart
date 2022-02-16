import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FidelityAppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool hasBackButton;

  FidelityAppbarWidget({
    required this.title,
    this.hasBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline1,
      ),
      centerTitle: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      shadowColor: Colors.transparent,
      leading: hasBackButton
        ? IconButton(
            icon: Icon(
              Icons.arrow_back_outlined,
              color: Theme.of(context).colorScheme.primary,
            ),
            onPressed: () {
              Get.back();
            }
          )
        : Container(),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(40.0);
}
