import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/common/custom_drawer/custom_button/custom_icon_button.dart';
import 'package:shop_app/models/cart/cart_product_model.dart';

class CartTileWidget extends StatelessWidget {
  const CartTileWidget({Key? key, required this.cartProduct}) : super(key: key);

  final CartProductModel cartProduct;

  static const IconData delete_outline =
      IconData(0xe1bb, fontFamily: 'MaterialIcons');

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: cartProduct,
      child: Consumer<CartProductModel>(
        builder: (_, cartProduct, __) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 4.0),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 0.0, vertical: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 120,
                    width: 100,
                    child: Wrap(
                      //crossAxisAlignment: WrapCrossAlignment.start,
                      spacing: 5,
                      runSpacing: 5,
                      verticalDirection: VerticalDirection.down,
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.center,
                      children: [
                        Image.network(
                          cartProduct.product.images.first,
                          width: 100,
                          height: 80,
                        ),                        
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [                            
                            CustomIconButton(
                              iconData: Icons.remove_circle_outline_sharp,
                              color: (cartProduct.quantity == 1 ? Color.fromARGB(255, 122, 118, 118) : Theme.of(context).primaryColor),
                              onTap: (cartProduct.quantity == 1 ? ()=>{} : cartProduct.decrement),
                            ),
                            Container(
                              padding: EdgeInsets.all(6.0),
                              child: Text(
                                '${cartProduct.quantity}',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color.fromARGB(255, 238, 234, 234),
                                    width: 2.0,
                                    style: BorderStyle.solid),
                                //borderRadius: BorderRadius.circular(50.0),
                              ),
                            ),
                            CustomIconButton(
                              iconData: Icons.add_circle_outline_sharp,
                              color: Theme.of(context).primaryColor,
                              onTap: cartProduct.increment,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                        ),
                        child: Text(
                          cartProduct.product.name,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // SizedBox(
                          //   child: Text('${cartProduct.quantity}'),
                          //   height: 22.0,
                          // ),
                          SizedBox(
                            child: Text('Tamanho: ${cartProduct.size}'),
                            height: 22.0,
                          ),
                          Row(
                            children: [
                              Text(
                                'R\$ 39,99',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 122, 118, 118),
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'R\$ 19,99',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                width: 25,
                              ),
                              Icon(
                                Icons.discount,
                                color: Color.fromARGB(255, 9, 243, 67),
                                size: 12,
                              ),
                              Text(
                                '26%',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 9, 243, 67),
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.end,
                              ),
                            ],
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(vertical: 8.0),
                          //   child: Row(
                          //     children: [
                          //       Expanded(
                          //         child: Column(
                          //           crossAxisAlignment: CrossAxisAlignment.center,
                          //           children: [
                          //             Text(
                          //               "alterar e-mail",
                          //               style: TextStyle(
                          //                   fontSize: 16,
                          //                   color: Colors.primaries.first),
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //       Expanded(
                          //         child: Column(
                          //           crossAxisAlignment: CrossAxisAlignment.center,
                          //           children: [
                          //             Text(
                          //               "alterar senha",
                          //               style: TextStyle(
                          //                   fontSize: 16,
                          //                   color: Colors.primaries.first),
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                      trailing: CustomIconButton(
                        iconData: delete_outline,
                        color: Theme.of(context).primaryColor,
                        onTap: (() => {}),
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
