import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shop_app/models/products/product_model.dart';
import 'package:shop_app/views/product_detail/product_detail_view.dart';

class ProducListView extends StatelessWidget {
  const ProducListView({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.of(context)
          .pushNamed(ProductDetailView.routeName.toString(), arguments: product) 
      },
      child: Wrap(        
        children: <Widget>[
          Align(
            alignment: Alignment.center,

            //padding: EdgeInsets.all(4.0),
            child: Image.network(
              product.images.first,
              width: 100,
              height: 100,
            ),
          ),
          Container(
            height: 18,
            color: Color.fromARGB(255, 16, 62, 83),
            //padding: EdgeInsets.all(8.0),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.star,
                    size: 12,
                    color: Colors.lime[700],
                  ),
                  Text(
                    "PRODUTOS CAMPEÕES",
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      //fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text(
              product.name,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
          ),
          Text(
            'R\$ 299.99',
            style: TextStyle(
              fontSize: 12,
              color: Color.fromARGB(255, 122, 118, 118),
              decoration: TextDecoration.lineThrough,
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  "R\$ 199,99",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
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
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2),
            child: Text(
              'Até em 4x de R\$ 75,00',
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
