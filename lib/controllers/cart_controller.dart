import 'package:shop_app/controllers/account_controller.dart';
import 'package:shop_app/models/cart/cart_product_model.dart';
import 'package:shop_app/models/products/product_model.dart';
import 'package:shop_app/models/users/user_model.dart';
import 'package:shop_app/repositories/cart_repository.dart';
import 'package:flutter/material.dart';

class CartController extends ChangeNotifier {

  List<CartProductModel>? items = [];
  late CartRepository repository;
  UserModel? userModel = null;

  void updateAccount(AccountController accountController){
    userModel = accountController.user;
    items?.clear();

    print("updateCart $userModel");

    if(userModel != null){
      _loadCartItems();
    }
  }

  Future<void> _loadCartItems() async {

    print("_loadCartItems");

    repository = CartRepository();
    
    items = await repository.loadCartItems();
  }

  void addToCart(ProductModel product){

    try{
      final e = items?.firstWhere((p) => p.stackable(product));
      //e?.quantity++;
      e?.increment();
      notifyListeners();
        
    }catch(e){
      repository = CartRepository();

      print("product add"  + product.toJson().toString());

      var item = CartProductModel.fromProduct(product);      
      item.addListener(_OnItemUpdated);

      items?.add(item);

      repository.addToCart(item);

      notifyListeners();
    }

    //notifyListeners();
     
  }

  void _OnItemUpdated(){
    for(final cartProductModel in items!){
      repository.updateCartProduct(cartProductModel);
    }
  }


  

}