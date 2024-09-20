import 'package:flutter/material.dart';

class BaseButton extends StatelessWidget {
  final void Function() onTap;
  final Widget? child;

  const BaseButton({
    super.key,
    required this.onTap,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(12),
            // boxShadow: [
            //   BoxShadow(
            //     color: Theme.of(context).colorScheme.inversePrimary,
            //     blurRadius: 10,
            //     offset: const Offset(0, 1),
            //   )
            // ],
          ),
          padding: const EdgeInsets.all(25),
          child: child,
        ),
      ),
    );
  }
}
