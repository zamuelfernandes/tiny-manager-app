import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'dart:async';

import '../../app/models/product_model.dart';
import '../constants/sheet.dart';

class SheetsRepository extends ChangeNotifier {
// can be extracted from your google sheets url.
  String deploymentID = dotenv.env['DEPLOYMENT_ID']!;
  String sheetID = dotenv.env['SHEET_ID']!;

  //PRODUCTS FOR SALE
  List<ProductModel> get shop => _shop;

  final List<ProductModel> _shop = [
    ProductModel(
      id: 0,
      name: 'Product 1',
      type: '',
      price: 99.99,
      description: 'Item description..',
      imagePath:
          'https://instagram.fbsb9-1.fna.fbcdn.net/v/t51.29350-15/453129861_371788845735365_2246964140458180923_n.jpg?stp=dst-jpg_e35&efg=eyJ2ZW5jb2RlX3RhZyI6ImltYWdlX3VybGdlbi4xMzUweDE2ODcuc2RyLmYyOTM1MC5kZWZhdWx0X2ltYWdlIn0&_nc_ht=instagram.fbsb9-1.fna.fbcdn.net&_nc_cat=105&_nc_ohc=x9ruvy1A3_gQ7kNvgHL9-x6&_nc_gid=ce6a649988ee4942893e2dae810d74dd&edm=AFg4Q8wBAAAA&ccb=7-5&ig_cache_key=MzQyMjkyNjkyMDgxMzczMTc4NQ%3D%3D.3-ccb7-5&oh=00_AYAXld_Ame2Ie5D9mogbQ2I4vD-AkiAK6nnS33LJ2z8O2A&oe=66E78605&_nc_sid=0b30b7',
    ),
    ProductModel(
      id: 0,
      name: 'Product 2',
      type: '',
      price: 99.99,
      description: 'Item description..',
      imagePath:
          'https://instagram.fbsb9-1.fna.fbcdn.net/v/t51.29350-15/453129861_371788845735365_2246964140458180923_n.jpg?stp=dst-jpg_e35&efg=eyJ2ZW5jb2RlX3RhZyI6ImltYWdlX3VybGdlbi4xMzUweDE2ODcuc2RyLmYyOTM1MC5kZWZhdWx0X2ltYWdlIn0&_nc_ht=instagram.fbsb9-1.fna.fbcdn.net&_nc_cat=105&_nc_ohc=x9ruvy1A3_gQ7kNvgHL9-x6&_nc_gid=ce6a649988ee4942893e2dae810d74dd&edm=AFg4Q8wBAAAA&ccb=7-5&ig_cache_key=MzQyMjkyNjkyMDgxMzczMTc4NQ%3D%3D.3-ccb7-5&oh=00_AYAXld_Ame2Ie5D9mogbQ2I4vD-AkiAK6nnS33LJ2z8O2A&oe=66E78605&_nc_sid=0b30b7',
    ),
    ProductModel(
      id: 0,
      name: 'Product 3',
      type: '',
      price: 99.99,
      description: 'Item description..',
      imagePath:
          'https://instagram.fbsb9-1.fna.fbcdn.net/v/t51.29350-15/453129861_371788845735365_2246964140458180923_n.jpg?stp=dst-jpg_e35&efg=eyJ2ZW5jb2RlX3RhZyI6ImltYWdlX3VybGdlbi4xMzUweDE2ODcuc2RyLmYyOTM1MC5kZWZhdWx0X2ltYWdlIn0&_nc_ht=instagram.fbsb9-1.fna.fbcdn.net&_nc_cat=105&_nc_ohc=x9ruvy1A3_gQ7kNvgHL9-x6&_nc_gid=ce6a649988ee4942893e2dae810d74dd&edm=AFg4Q8wBAAAA&ccb=7-5&ig_cache_key=MzQyMjkyNjkyMDgxMzczMTc4NQ%3D%3D.3-ccb7-5&oh=00_AYAXld_Ame2Ie5D9mogbQ2I4vD-AkiAK6nnS33LJ2z8O2A&oe=66E78605&_nc_sid=0b30b7',
    ),
    ProductModel(
      id: 0,
      name: 'Product 4',
      type: '',
      price: 99.99,
      description: 'Item description..',
      imagePath:
          'https://instagram.fbsb9-1.fna.fbcdn.net/v/t51.29350-15/453129861_371788845735365_2246964140458180923_n.jpg?stp=dst-jpg_e35&efg=eyJ2ZW5jb2RlX3RhZyI6ImltYWdlX3VybGdlbi4xMzUweDE2ODcuc2RyLmYyOTM1MC5kZWZhdWx0X2ltYWdlIn0&_nc_ht=instagram.fbsb9-1.fna.fbcdn.net&_nc_cat=105&_nc_ohc=x9ruvy1A3_gQ7kNvgHL9-x6&_nc_gid=ce6a649988ee4942893e2dae810d74dd&edm=AFg4Q8wBAAAA&ccb=7-5&ig_cache_key=MzQyMjkyNjkyMDgxMzczMTc4NQ%3D%3D.3-ccb7-5&oh=00_AYAXld_Ame2Ie5D9mogbQ2I4vD-AkiAK6nnS33LJ2z8O2A&oe=66E78605&_nc_sid=0b30b7',
    ),
  ];

  Future<Map> triggerWebAPP({required Map body}) async {
    String sheetUrl = "https://script.google.com/macros/s/$deploymentID/exec";
    Map dataDict = {};

    try {
      await http.post(Uri.parse(sheetUrl), body: body).then((response) async {
        if ([200, 201].contains(response.statusCode)) {
          dataDict = jsonDecode(response.body);
        }
        if (response.statusCode == 302) {
          String redirectedUrl = response.headers['location'] ?? "";
          if (redirectedUrl.isNotEmpty) {
            Uri url = Uri.parse(redirectedUrl);
            await http.get(url).then((response) {
              if ([200, 201].contains(response.statusCode)) {
                dataDict = jsonDecode(response.body);
              }
            });
          }
        } else {
          print("Other StatusCOde: ${response.statusCode}");
        }
      });
    } catch (e) {
      print("FAILED: $e");
    }

    return dataDict;
  }

  // COLUMNS OR READ
  Future<Map> getSheetsData({
    required String action,
    required String sheetName,
  }) async {
    Map body = {
      "sheetID": sheetID,
      "action": action,
      "sheetName": sheetName,
    };

    Map dataDict = await triggerWebAPP(body: body);

    return dataDict;
  }

  Future<void> uploadData({
    required Map sendDataDict,
    required String sheetName,
  }) async {
    final dateNow = DateTime.now();
    sendDataDict.addAll(
      {"DATA": '${dateNow.day}/${dateNow.month}'},
    );

    Map<String, dynamic> body = {
      "sheetID": sheetID,
      "action": Sheet.actionInsert,
      "sheetName": sheetName,
      "rowInfo": jsonEncode(sendDataDict),
    };

    print("triggering insert... body: $body");
    Map dataDict = await triggerWebAPP(body: body);

    print("upload response dataDict: $dataDict");
  }

  Future<void> deleteDataById({
    required int id,
    required String sheetName,
  }) async {
    Map<String, dynamic> body = {
      "sheetID": sheetID,
      "action": Sheet.actionDeleteById,
      "sheetName": sheetName,
      "id": id.toString(), // Passando o nome do produto
    };

    print("triggering delete... body: $body");
    Map dataDict = await triggerWebAPP(body: body);

    print("delete response dataDict: $dataDict");
  }
}
