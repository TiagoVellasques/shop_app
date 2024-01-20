import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/products/product_model.dart';
import 'package:shop_app/models/products/product_size_model.dart';

class CartProductModel extends ChangeNotifier {
  
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  CartProductModel.fromProduct(this.product){
    productId = product.id;
    quantity = 1;
    size = product.selectedSize!.name.toString();
  }

  CartProductModel.fromDocument(DocumentSnapshot document){

    print("PRODUCT ID " + document.id.toString());

    id =  document.id.toString();
    productId = document["pid"];
    quantity =  document['quantity'] as int;
    size = document['size'] as String; 

    firestore.doc("products/$productId").get().then((doc) => {

      print("firestore ID " + doc.toString()),

      product = ProductModel.fromDocument(doc)
    });
  }

  late String id;
  late String productId;
  late int quantity;
  late String size;

  late ProductModel product;

  ProductSizeModel? get productSize {
    if(product == null) return null;
    return product.findSize(size);
  }

  num get unitPrice{
    if(product == null) return 0;
    return productSize?.price ?? 0;
  }

  Map<String, dynamic> toCartItemMap(){
    return {
      'pid': productId,
      'quantity': quantity,
      'size': size,
    };
  }

  bool stackable(ProductModel product){
    return product.id == productId && product.selectedSize?.name == size;
  }

  void increment(){
    quantity++;
    notifyListeners();
  }

  void decrement(){

    quantity--;    
    notifyListeners();
  }

}