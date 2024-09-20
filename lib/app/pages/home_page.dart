import 'package:flutter/material.dart';

import '../components/base_app_bar.dart';
import '../components/base_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar(
        title: 'Home Page',
      ),
      drawer: const BaseDrawer(),
      body: Container(),
    );
  }
}
