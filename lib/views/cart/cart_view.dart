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
      appBar:AppBar(
        backgroundColor: Colors.white,
        leading: const BackButton(
          color: Colors.red,
        ),
        // iconTheme: IconThemeData(
        //   color: Colors.primaries.first, //change your color here
        // ),
        title: const Text(
          'Sacola',
          style: TextStyle(color: Colors.red),
        ),
        elevation: 0,
        //centerTitle: true,
      ),
      body: Consumer<CartController>(
        builder: (_, cart_controller, __) {
          return  ListView(
            padding: const EdgeInsets.all(0.0),
            children: <Widget>[
              // Padding(
              //   padding:  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 12.0),
              //   child: Text(
              //     "Meus dados",
              //     style: TextStyle(
              //       fontSize: 22,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),
              //SizedBox(height: 20,),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: cart_controller.items!
                    .map((cart) => CartTileWidget(cartProduct: cart))
                    .toList(),
              ),

            ],
          );
        },
      ),
    );
  }
}
