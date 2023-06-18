import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shop_app/models/cart/cart_product_model.dart';

class CartTileWidget extends StatelessWidget {
  const CartTileWidget({Key? key, required this.cartProduct}) : super(key: key);

  final CartProductModel cartProduct;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            SizedBox(
              height: 80,
              width: 80,
              child: Image.network(cartProduct.product.images.first),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Wrap(
                  spacing: 12.0,
                  runSpacing: 10.0,
                  alignment: WrapAlignment.start,
                  children: [
                    Text(
                      cartProduct.product.name,
                      style: TextStyle(fontWeight: FontWeight.w500,
                      fontSize: 17.0,
                      ),
                    ),
                    Text(
                      'Tamanho: ${cartProduct.size}',
                      style: TextStyle(fontWeight: FontWeight.w300),
                    ),
                    Text(
                      'R\$ ${cartProduct.unitPrice.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
