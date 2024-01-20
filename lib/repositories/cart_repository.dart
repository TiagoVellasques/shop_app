import 'package:flutter/cupertino.dart';
import 'package:shop_app/models/cart/cart_product_model.dart';
import 'package:shop_app/models/users/user_model.dart';
import 'package:shop_app/services/user_service.dart';
import 'package:shop_app/view_models/signup_viewmodel.dart';

import '../services/cart_service.dart';

class CartRepository {

  late CartService cartService;

  Future<List<CartProductModel>?> loadCartItems() async {
    cartService = CartService();
    var list = cartService.loadCartUser();

    return list;
  }

  Future<List<CartProductModel>?> addToCart(CartProductModel cart) async {
    cartService = CartService();
    var list = cartService.addToCart(cart);

    //return list;
  }

  void updateCartProduct(CartProductModel cartProductModel){
    cartService = CartService();
    cartService.updateCartProduct(cartProductModel);
  }

}