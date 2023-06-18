import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/controllers/cart_controller.dart';
import 'package:shop_app/views/cart/components/cart_tile.dart';

class CartView extends StatelessWidget {
  const CartView({Key? key}) : super(key: key);

  static String routeName = "/cart";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Carrinho"),
        centerTitle: true,
      ),
      body: Consumer<CartController>(
        builder: (_, cart_controller, __) {
          return Column(
            children: cart_controller.items
                .map((cart) => CartTileWidget(cartProduct: cart))
                .toList(),
          );
        },
      ),
    );
  }
}
