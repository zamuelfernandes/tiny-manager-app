class InputModel {
  final int id;
  final DateTime data;
  final String cliente;
  final String meioDePagamento;
  final String canalDeVenda;
  final String box;
  final double valor;

  InputModel({
    required this.id,
    required this.data,
    required this.cliente,
    required this.meioDePagamento,
    required this.canalDeVenda,
    required this.box,
    required this.valor,
  });

  // Método para mapear dados de um Map para uma lista de InputModels
  static List<InputModel> mapDataToInputList(Map<dynamic, dynamic> map) {
    List<InputModel> pedidoList = [];

    // Extrair as colunas e os dados do Map
    List<dynamic> columns = map['columns'];
    List<dynamic> data = map['data'];

    // Mapear cada item da lista "data" para um Pedido
    for (var row in data) {
      pedidoList.add(
        InputModel(
          id: int.parse(row[columns.indexOf('ID')].toString()),
          data: DateTime.parse(row[columns.indexOf('DATA')].toString()),
          cliente: row[columns.indexOf('CLIENTE')].toString(),
          meioDePagamento: row[columns.indexOf('MEIO DE PAGAMENTO')].toString(),
          canalDeVenda: row[columns.indexOf('CANAL DE VENDA')].toString(),
          box: row[columns.indexOf('BOX')].toString(),
          valor:
              double.tryParse(row[columns.indexOf('VALOR')].toString()) ?? 0.0,
        ),
      );
    }

    return pedidoList;
  }
}
