class ProductModel {
  final int id;
  final String name;
  final String type;
  final double price;
  final String description;
  final String imagePath;

  ProductModel({
    required this.id,
    required this.name,
    required this.type,
    required this.price,
    required this.description,
    required this.imagePath,
  });

  static List<ProductModel> mapDataToProductList(Map<dynamic, dynamic> map) {
    List<ProductModel> productList = [];

    // Extrair as colunas e os dados do Map
    List<dynamic> columns = map['columns'];
    List<dynamic> data = map['data'];

    // Mapear cada item da lista "data" para um ProductModel
    for (var row in data) {
      productList.add(
        ProductModel(
          id: int.parse(row[columns.indexOf('ID')].toString()),
          name: row[columns.indexOf('NAME')].toString(),
          type: row[columns.indexOf('TYPE')].toString(),
          price:
              double.tryParse(row[columns.indexOf('PRICE')].toString()) ?? 0.0,
          description: row[columns.indexOf('DESCRIPTION')].toString(),
          imagePath: row[columns.indexOf('IMAGE')].toString(),
        ),
      );
    }

    return productList;
  }
}
