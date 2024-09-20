import 'package:flutter/material.dart';

import '../components/base_button.dart';
import '../../shared/constants/routes.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.store,
              size: 72,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            const SizedBox(height: 25),
            const Text(
              'Tiny Donuts',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Welcome to Tiny Donuts!',
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            const SizedBox(height: 25),
            BaseButton(
              onTap: () => Navigator.pushNamed(context, Routes.homePage),
              child: const Icon(Icons.arrow_forward),
            ),
          ],
        ),
      ),
    );
  }
}
