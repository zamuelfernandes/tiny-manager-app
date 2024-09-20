import 'package:flutter/material.dart';

import '../../app/pages/inputs_page.dart';
import '../../app/pages/intro_page.dart';
import '../../app/pages/outputs_page.dart';
import '../../app/pages/products_page.dart';
import '../../app/pages/home_page.dart';

class Routes {
  static const introPage = '/intro_page';
  static const homePage = '/home_page';
  static const productsPage = '/products_page';
  static const inputsPage = '/inputs_page';
  static const outputsPage = '/outputs_page';
}

Map<String, Widget Function(BuildContext)> appRoutes = {
  Routes.introPage: (context) => const IntroPage(),
  Routes.homePage: (context) => const HomePage(),
  Routes.productsPage: (context) => const ProductsPage(),
  Routes.inputsPage: (context) => const InputsPage(),
  Routes.outputsPage: (context) => const OutputsPage(),
};
