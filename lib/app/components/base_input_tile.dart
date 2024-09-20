import 'package:flutter/material.dart';

import '../models/input_model.dart';

class BaseInputTile extends StatelessWidget {
  final InputModel inputModel;
  final void Function()? onTap;

  const BaseInputTile({
    super.key,
    required this.inputModel,
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
                  // Cliente (nome do cliente com estilo destacado)
                  Row(
                    children: [
                      const Icon(Icons.person, color: Colors.blueAccent),
                      const SizedBox(width: 8),
                      Text(
                        'Cliente: ${inputModel.cliente}',
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
                        'Data: ${inputModel.data.toLocal().toString().split(' ')[0].replaceAll(RegExp(r'-'), "/")}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),

                  // Meio de Pagamento
                  Row(
                    children: [
                      const Icon(Icons.credit_card, color: Colors.orange),
                      const SizedBox(width: 8),
                      Text(
                        'Meio de Pagamento: ${inputModel.meioDePagamento}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),

                  // Canal de Venda
                  Row(
                    children: [
                      const Icon(Icons.store, color: Colors.purple),
                      const SizedBox(width: 8),
                      Text(
                        'Canal de Venda: ${inputModel.canalDeVenda}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),

                  // Box
                  Row(
                    children: [
                      const Icon(Icons.inbox, color: Colors.teal),
                      const SizedBox(width: 8),
                      Text(
                        'Box: ${inputModel.box}',
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
                        'Valor: R\$ ${inputModel.valor.toStringAsFixed(2)}',
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
