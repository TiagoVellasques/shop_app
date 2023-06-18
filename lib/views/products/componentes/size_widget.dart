import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/products/product_model.dart';
import 'package:shop_app/models/products/product_size_model.dart';

class SizeWidget extends StatelessWidget {
  
  SizeWidget({required this.size});

  final ProductSizeModel size;
  
  @override
  Widget build(BuildContext context) {
    final product = context.watch<ProductModel>();

    //print(product.toJson());

    late bool selected = false;
    if(product.selectedSize != null)
        selected = size == product.selectedSize;

    //final selected = false;
    
   print("SizeWidget =>>>>> ${this.size}");

    return GestureDetector(
      onTap: (){
        if(size.hasStock){          
          product.selectedSize = size;
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          border: Border.all(
            color: selected ? Colors.red.shade700 : Colors.grey,
          ),
        ),
        child: Row(        
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(            
              color: !size.hasStock ? Colors.red.withAlpha(50) : Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
              child: Text(
                size.name,
                style: TextStyle(color: Colors.grey),
              ),
            ),          
          ]
        ),
      ),
    );
  }
}