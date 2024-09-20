import 'package:flutter/material.dart';
import '../models/output_model.dart';

class BaseOutputTile extends StatelessWidget {
  final OutputModel outputModel;
  final void Function()? onTap;

  const BaseOutputTile({
    super.key,
    required this.outputModel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(5),
          child: Card(
            elevation: 3,
            margin: const EdgeInsets.all(5),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Produto (nome do Produto com estilo destacado)
                  Row(
                    children: [
                      const Icon(Icons.receipt, color: Colors.blueAccent),
                      const SizedBox(width: 8),
                      Text(
                        'Produto: ${outputModel.item}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Divider(color: Colors.grey[300]),

                  // Data
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, color: Colors.green),
                      const SizedBox(width: 8),
                      Text(
                        'Data: ${outputModel.data.toLocal().toString().split(' ')[0].replaceAll(RegExp(r'-'), "/")}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),

                  // Categoria
                  Row(
                    children: [
                      const Icon(Icons.store, color: Colors.orange),
                      const SizedBox(width: 8),
                      Text(
                        'Categoria: ${outputModel.categoria}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),

                  // Quantidade
                  Row(
                    children: [
                      const Icon(Icons.menu, color: Colors.purple),
                      const SizedBox(width: 8),
                      Text(
                        'Quantidade: ${outputModel.quantidadeUnidade}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),

                  // Valor
                  Row(
                    children: [
                      const Icon(Icons.attach_money, color: Colors.red),
                      const SizedBox(width: 8),
                      Text(
                        'Valor: R\$ ${outputModel.valor.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: InkWell(
            onTap: onTap,
            child: const Card(
              color: Colors.red,
              shape: CircleBorder(),
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Icon(
                  Icons.close,
                  size: 15,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
