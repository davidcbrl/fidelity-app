import 'package:flutter/material.dart';

class FidelityAppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  FidelityAppbarWidget({
    required this.title,
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
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(40.0);
}
