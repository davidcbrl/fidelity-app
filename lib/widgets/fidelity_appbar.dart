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
        style: Theme.of(context).textTheme.titleLarge,
      ),
      centerTitle: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      elevation: 0,
      leading: hasBackButton
        ? IconButton(
            icon: Icon(
              Icons.arrow_back_outlined,
              color: Theme.of(context).colorScheme.primary,
            ),
            onPressed: () {
              Get.back();
              FocusScope.of(context).unfocus();
            }
          )
        : Container(),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(40.0);
}
