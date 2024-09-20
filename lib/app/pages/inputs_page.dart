import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../shared/constants/sheet.dart';
import '../../shared/services/sheets_repository.dart';
import '../components/base_app_bar.dart';
import '../components/base_input_tile.dart';
import '../components/base_text_field.dart';
import '../components/base_text_snack_bar.dart';
import '../models/input_model.dart';

// ENTRADA
// DATA, CLIENTE, MEIO DE PAGAMENTO, CANAL DE VENDA, BOX, VALOR (Pré Inserido com base na Box), UNIDADES POR SABOR,
class InputsPage extends StatefulWidget {
  const InputsPage({super.key});

  @override
  State<InputsPage> createState() => _InputsPageState();
}

class _InputsPageState extends State<InputsPage> {
  bool canAdd = false;
  Future<Map> _getDataFromSheets(BuildContext context) async {
    Map dataDict = await context.watch<SheetsRepository>().getSheetsData(
          action: Sheet.actionRead,
          sheetName: Sheet.sheetInputs,
        );

    canAdd = true;

    return dataDict;
  }

  void loadData() async {
    respBody = await SheetsRepository().getSheetsData(
      action: Sheet.actionGetColumns,
      sheetName: Sheet.sheetInputs,
    );
  }

  Map respBody = {};

  final textControllers = <String, TextEditingController>{};

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: 'Inputs',
        actions: [
          IconButton(
            onPressed: () {
              if (canAdd) {
                registerInput(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  BaseTextSnackBar.create(
                    text: 'Aguarde o carregamento das informações',
                    backgroundColor: Colors.yellow.shade700,
                    textColor: Colors.white,
                  ),
                );
              }
            },
            icon: const Icon(Icons.add_chart_rounded),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Text(
                'My lasts Inputs',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * .8,
              child: FutureBuilder<Map>(
                future: _getDataFromSheets(context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  }
                  if (!snapshot.hasData) {
                    return const Center(
                      child: Text('No data available'),
                    );
                  }

                  final inputs = InputModel.mapDataToInputList(snapshot.data!);

                  return ListView.builder(
                    itemCount: inputs.length,
                    padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                    itemBuilder: (ctx, index) {
                      final input = inputs[index];
                      return BaseInputTile(
                        inputModel: input,
                        onTap: () => confirmDialog(input),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void registerInput(context) async {
    List columns = respBody["data"];

    for (var element in columns) {
      textControllers[element] = TextEditingController();
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          "Add Input",
          textAlign: TextAlign.center,
        ),
        scrollable: true,
        actionsAlignment: MainAxisAlignment.spaceAround,
        content: SingleChildScrollView(
          child: Column(
            children: List.generate(columns.length, (index) {
              Padding textField = const Padding(padding: EdgeInsets.zero);

              if (columns[index] != 'DATA' && columns[index] != 'ID') {
                textField = Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: BaseTextField(
                    controller: textControllers[columns[index]],
                    labelText: columns[index],
                  ),
                );
              }

              return textField;
            }),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              textControllers.forEach((key, value) {
                value.clear();
              });
            },
            icon: const Icon(Icons.clean_hands),
          ),
          IconButton(
            onPressed: () async {
              Map dataDict = {};

              textControllers.forEach((key, tcontroller) {
                dataDict[key.toString()] = tcontroller.text.toString();
              });

              await Provider.of<SheetsRepository>(
                context,
                listen: false,
              ).uploadData(
                sendDataDict: dataDict,
                sheetName: Sheet.sheetInputs,
              );

              setState(() {
                Navigator.of(context).pop();
              });
            },
            icon: const Icon(Icons.save),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close),
          ),
        ],
      ),
    );
  }

  void confirmDialog(InputModel p) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          "CONFIRMATION",
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        content: Text(
          'Are you sure to delete the ${p.box} box of ${p.cliente}?',
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);

              await SheetsRepository().deleteDataById(
                id: p.id,
                sheetName: Sheet.sheetInputs,
              );

              await Future.delayed(
                const Duration(milliseconds: 500),
              );
              setState(() {});
            },
            child: const Text(
              'Delete',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
