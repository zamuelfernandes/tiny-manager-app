import 'package:flutter/material.dart';

import '../models/product_model.dart';

class BaseProductTile extends StatelessWidget {
  final ProductModel product;
  final void Function()? onTap;

  const BaseProductTile({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    String name = '${product.name} - ${product.type}';

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(5),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
            child: Container(
              height: 70,
              width: double.infinity,
              margin: const EdgeInsets.all(8),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      product.imagePath,
                      fit: BoxFit.cover,
                      height: 60,
                      width: 60,
                      errorBuilder: (context, error, stackTrace) {
                        return const SizedBox(
                          height: 60,
                          width: 60,
                          child: Center(
                            child: Icon(Icons.image),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name.length > 25 ? '${name.substring(0, 20)}...' : name,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        product.description,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
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
