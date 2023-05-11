import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/products/product_model.dart';
import 'package:shop_app/views/products/componentes/size_widget.dart';

class ProductDetailView extends StatelessWidget {
  static var routeName = '/product_detail';

  const ProductDetailView(this.product);

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Colors.grey.shade700;

    const IconData icon_share = IconData(0xe593, fontFamily: 'MaterialIcons');
    const IconData icon_shopping_cart = IconData(0xe59c, fontFamily: 'MaterialIcons');

    return ChangeNotifierProvider.value(
      value: product,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: const BackButton(
            color: Colors.red,
          ),
          actions: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Icon(
                icon_share,
                color: Colors.red,
                size: 30.0,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Icon(
                icon_shopping_cart,
                color: Colors.red,
                size: 30.0,
              ),
            ),
          ],
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ListView(
            children: [
              SizedBox(
                height: 400,
                width: double.infinity,
                child: Carousel(
                  boxFit: BoxFit.cover,
                  images: product.images.map((e) {
                    return NetworkImage(e);
                  }).toList(),
                  //animationDuration: Duration(milliseconds: 1000),
                  autoplay: false,
                  dotColor: Colors.grey,
                  dotBgColor: Colors.transparent,
                  dotHorizontalPadding: 10.0,
                  dotSize: 5.0,
                  dotSpacing: 15.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    Row(
                      verticalDirection: VerticalDirection.up,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            'Ref.:' + '968541',
                            style: TextStyle(color: Colors.grey[700], fontSize: 13),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.amber.shade400,
                          size: 18,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.amber.shade400,
                          size: 18,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.amber.shade400,
                          size: 18,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          '(37)',
                          style: TextStyle(color: Colors.grey[700], fontSize: 13),
                        ),
                      ],
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
                            fontSize: 24,
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
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
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 2),
                      child: Text(
                        'Até em 4x de R\$ 75,00 sem juros',
                        style: TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 122, 118, 118)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 5),
                      child: Text('Tamanho do produto',
                          style: TextStyle(color: Colors.grey[700], fontSize: 13)),
                    ),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: product.sizes.map((e) {
                        return SizeWidget(size: e);
                      }).toList(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 5),
                      child: Text('Descrição',
                          style: TextStyle(color: Colors.grey[700], fontSize: 13)),
                    ),
                    Text(
                      product.description,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Color.fromARGB(255, 122, 118, 118),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
