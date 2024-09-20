import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../shared/constants/sheet.dart';
import '../../shared/services/sheets_repository.dart';
import '../components/base_app_bar.dart';
import '../components/base_output_tile.dart';
import '../components/base_text_field.dart';
import '../components/base_text_snack_bar.dart';
import '../models/output_model.dart';

// SAÍDA
// DATA, ITEM, CATEGORIA, QUANTIDADE/UNIDADE, VALOR
class OutputsPage extends StatefulWidget {
  const OutputsPage({super.key});

  @override
  State<OutputsPage> createState() => _OutputsPageState();
}

class _OutputsPageState extends State<OutputsPage> {
  bool canAdd = false;
  Future<Map> _getDataFromSheets(BuildContext context) async {
    Map dataDict = await context.watch<SheetsRepository>().getSheetsData(
          action: Sheet.actionRead,
          sheetName: Sheet.sheetOutputs,
        );

    canAdd = true;

    return dataDict;
  }

  void loadData() async {
    respBody = await SheetsRepository().getSheetsData(
      action: Sheet.actionGetColumns,
      sheetName: Sheet.sheetOutputs,
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
        title: 'Outputs',
        actions: [
          IconButton(
            onPressed: () {
              if (canAdd) {
                registerOutput(context);
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
            icon: const Icon(Icons.add_shopping_cart),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Text(
                'My last Outputs',
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

                  final outputs =
                      OutputModel.mapDataToOutputList(snapshot.data!);

                  return ListView.builder(
                    itemCount: outputs.length,
                    padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                    itemBuilder: (ctx, index) {
                      final output = outputs[index];
                      return BaseOutputTile(
                        outputModel: output,
                        onTap: () => confirmDialog(output),
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

  void registerOutput(BuildContext context) async {
    List columns = respBody["data"];

    for (var element in columns) {
      textControllers[element] = TextEditingController();
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          "Add Output",
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
                sheetName: Sheet.sheetOutputs,
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

  void confirmDialog(OutputModel p) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          "CONFIRMATION",
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        content: Text(
          'Are you sure to delete Output of ${p.item}?',
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
                sheetName: Sheet.sheetOutputs,
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
