import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/pages/intro_page.dart';
import 'shared/constants/routes.dart';
import 'shared/services/env_config.dart';
import 'shared/services/sheets_repository.dart';
import 'shared/themes/light_mode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EnvConfig.init();

  runApp(
    ChangeNotifierProvider(
      create: (context) => SheetsRepository(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      routes: appRoutes,
      home: const IntroPage(),
    );
  }
}

// ENTRADA
// DATA, CLIENTE, MEIO DE PAGAMENTO, CANAL DE VENDA, BOX, VALOR (Pré Inserido com base na Box), UNIDADES POR SABOR, 

// SAIDA 
// DATA, ITEM, CATEGORIA, QUANTIDADE/UNIDADE, VALOR,

// PRODUTO
// NOME, TIPO, PREÇO, DESCRIÇÃO, URL-IMAGEM,

// GRÁFICOS
// ENTRADA/SAÍDA DA SEMANA, PORCENTAGEM PARA META MENSAL, PROPORÇÃO DE SABORES MAIS VENDIDOS