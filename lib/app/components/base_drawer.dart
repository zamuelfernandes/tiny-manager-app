import 'package:flutter/material.dart';

import '../../shared/constants/routes.dart';
import 'base_list_tile.dart';

class BaseDrawer extends StatelessWidget {
  const BaseDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                child: Center(
                  child: Icon(
                    Icons.shopping_bag_rounded,
                    size: 72,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
              ),
              const SizedBox(height: 25),
              BaseListTile(
                text: 'Home',
                icon: Icons.home_rounded,
                onTap: () => Navigator.pop(context),
              ),
              BaseListTile(
                text: 'Products',
                icon: Icons.cookie,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, Routes.productsPage);
                },
              ),
              BaseListTile(
                text: 'Inputs',
                icon: Icons.monetization_on,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, Routes.inputsPage);
                },
              ),
              BaseListTile(
                text: 'Outputs',
                icon: Icons.shopping_basket_rounded,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, Routes.outputsPage);
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: BaseListTile(
              text: 'Exit',
              icon: Icons.logout,
              onTap: () => Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.introPage,
                (route) => false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
