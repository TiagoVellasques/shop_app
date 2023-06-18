import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/products/product_size_model.dart';

class ProductModel extends ChangeNotifier {

  ProductModel({this.id = "", this.name = "", this.description = ""});

  late String id;
  late String name;
  late String description;  
  late List<String> images;  
  late List<ProductSizeModel> sizes;
  late String confirmPassword;

  ProductSizeModel? _selectedSize;
  ProductSizeModel? get selectedSize => _selectedSize;
  
  set selectedSize(ProductSizeModel? value){      
      _selectedSize = value;
      notifyListeners();
  }

  int get totalStock {
    int stock = 0;
    for(final size in sizes){
      stock += size.stock;
    }
    return stock;
  }

  ProductSizeModel? findSize(String name){
    try{
      return sizes.firstWhere((s) => s.name == name);
    }catch(e){
      return null;
    }
    
  }

  bool get hasStock{
    return totalStock > 0;
  }
  
  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'name': name,
      'description': description,   
    };
  }

  ProductModel.fromJson(Map<String, dynamic> json) {    
    id = json['id'];
    name = json['name'];
    description = json['description'];           
    sizes = json['size'];
  }

  ProductModel.fromDocument(DocumentSnapshot document) {   
      
    id = document.id;
    name =  document['name'].toString();
    description = document['description'].toString();
    //print(document.get("images"));
    images = List<String>.from(document.get("images") as List<dynamic>);
    sizes = (document.get('size') as List<dynamic> ?? []).map(
      (s) => ProductSizeModel.fromJson(s as Map<String, dynamic>)).toList();
  }
  
}