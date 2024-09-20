import 'package:flutter/material.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final List<Widget>? actions;
  final String? title;

  const BaseAppBar({
    super.key,
    this.leading,
    this.actions,
    this.title,
  });

  @override
  Size get preferredSize => const Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      leading: leading,
      actions: actions,
      title: title != null
          ? Text(
              title!.toUpperCase(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            )
          : const SizedBox(),
    );
  }
}
