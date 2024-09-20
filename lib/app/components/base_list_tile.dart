import 'package:flutter/material.dart';

class BaseListTile extends StatelessWidget {
  final IconData? icon;
  final String text;
  final void Function()? onTap;

  const BaseListTile({
    super.key,
    this.icon,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.black,
        ),
        title: Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
