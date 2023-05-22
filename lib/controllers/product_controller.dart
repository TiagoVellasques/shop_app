import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop_app/models/products/product_model.dart';
import 'package:shop_app/repositories/product_repository.dart';

class ProductController{
  late ProductRepository repository;
  
  int _currentPage = 1;
  List<ProductModel> allProducts = [];
  late var streamController = StreamController<List<ProductModel>>();
  
  void getProducts(String? name) {
    List<ProductModel> filteredProducts = [];

    streamController = StreamController<List<ProductModel>>(
      onListen: () async {

        allProducts = await repository.getAll();

        if(name!.isEmpty){          
          filteredProducts.addAll(allProducts);
        }else{
          filteredProducts.addAll(
            allProducts.where((p) => p.name.toLowerCase().contains(name.toString().toLowerCase())));
        }
        streamController.sink.add(filteredProducts);                
      },      
    );
  }

  ProductController() {        
    repository = ProductRepository();
    //getAll();
    //_loadCurrentUser();
  }

  Future<List<ProductModel>> getAll() async {    
    allProducts = await repository.getAll();
    streamController.sink.add(allProducts);
    _currentPage++;

    return allProducts;
    //notifyListeners();
  }
}
