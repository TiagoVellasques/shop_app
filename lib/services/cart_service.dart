import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/helpers/firebase_error.dart';
import 'package:shop_app/models/cart/cart_product_model.dart';
import 'package:shop_app/models/users/user_model.dart';
import 'package:shop_app/view_models/signup_viewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartService {
  
  UserModel? user;

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool loading = false;

  CartService() {
    //loadCurrentUser();
  }

  Future<void> create(UserModel user, String id) async {
    await firestore
        .collection('users')
        .doc(id)
        .set(user.toJson());
  }

  Future<void> addToCart(CartProductModel cart) async {
    final User currentUser = auth.currentUser!;

    if(currentUser.uid.isNotEmpty) {     

      final cartUser = await firestore.collection('users')        
        .doc(currentUser.uid)
        .collection("cart")
        .add(cart.toCartItemMap());
      
      print("list============>" + cartUser.id.toString());

      //notifyListeners();
      //return list;
    } else {
      print("usuário não está logado");
      throw Exception("Não foi possível adicionar ao carrinho");
      
    }
  }

  Future<List<CartProductModel>?> loadCartUser({User? firebaseUser}) async {
    final User currentUser = firebaseUser ?? auth.currentUser!;

    print("loadCartUser");

    if(currentUser.uid.isNotEmpty) {      
      final cartUser = await firestore.collection('users')        
        .doc(currentUser.uid)
        .collection("cart")
        .get();

      print("Produtos ----------> " + cartUser.toString());

      var list = cartUser.docs.map((e) => CartProductModel.fromDocument(e)..addListener(_onItemUpdated)).toList();

      print("list============>" + list.toString());

      //notifyListeners();
      return list;
    } else {
      print("usuário não está logado");
      return null;
    }
  }

  void _onItemUpdated()  {
    final list = loadCartUser().then((items) => {
      for(final cartProductModel in items!){
        updateCartProduct(cartProductModel)
      }      
    });
  }

  Future<void> updateCartProduct(CartProductModel? cartProductModel) async {
    final User currentUser = auth.currentUser!;


    print("updateCartProduct");
    print(currentUser.uid.isNotEmpty);
    print(cartProductModel?.toCartItemMap());

    if(currentUser.uid.isNotEmpty) {  

      await firestore.collection('users')        
        .doc(currentUser.uid)
        .collection("cart")
        .doc(cartProductModel!.id)
        .update(cartProductModel.toCartItemMap());

    }
    else {
      print("usuário não está logado");
      throw Exception("Não foi possível atualizar ao carrinho");
    }
  }
}
