class OutputModel {
  final int id;
  final DateTime data;
  final String item;
  final String categoria;
  final String quantidadeUnidade;
  final double valor;

  OutputModel({
    required this.id,
    required this.data,
    required this.item,
    required this.categoria,
    required this.quantidadeUnidade,
    required this.valor,
  });

  // Método para mapear dados de um Map para uma lista de OutputModels
  static List<OutputModel> mapDataToOutputList(Map<dynamic, dynamic> map) {
    List<OutputModel> outputList = [];

    // Extrair as colunas e os dados do Map
    List<dynamic> columns = map['columns'];
    List<dynamic> data = map['data'];

    // Mapear cada item da lista "data" para um OutputModel
    for (var row in data) {
      outputList.add(
        OutputModel(
          id: int.parse(row[columns.indexOf('ID')].toString()),
          data: DateTime.parse(row[columns.indexOf('DATA')].toString()),
          item: row[columns.indexOf('ITEM')].toString(),
          categoria: row[columns.indexOf('CATEGORIA')].toString(),
          quantidadeUnidade:
              row[columns.indexOf('QUANTIDADE/UNIDADE')].toString(),
          valor:
              double.tryParse(row[columns.indexOf('VALOR')].toString()) ?? 0.0,
        ),
      );
    }

    return outputList;
  }
}
