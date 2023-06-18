import 'package:shop_app/controllers/account_controller.dart';
import 'package:shop_app/models/cart/cart_product_model.dart';
import 'package:shop_app/models/products/product_model.dart';
import 'package:shop_app/models/users/user_model.dart';

class CartController {

  List<CartProductModel> items = [];

  UserModel? userModel;

  void updateAccount(AccountController accountController){
    userModel = accountController.user;
  }

  void addToCart(ProductModel product){
    items.add(CartProductModel.fromProduct(product));
  }

}