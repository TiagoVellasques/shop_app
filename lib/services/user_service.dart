import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/helpers/firebase_error.dart';
import 'package:shop_app/models/cart/cart_product_model.dart';
import 'package:shop_app/models/users/user_model.dart';
import 'package:shop_app/view_models/signup_viewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  
  UserModel? user;

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool loading = false;

  UserService() {
    //loadCurrentUser();
  }

  Future<UserModel> signIn(SignupViewModel model) async {
    //setLoading(true);
    try {
      
      UserCredential result = await auth.signInWithEmailAndPassword(
          email: model.email.toString(), password: model.password.toString());

      // ignore: avoid_print
      //this.user = result.user;

      await loadCurrentUser(firebaseUser: result.user);

      await Future.delayed(const Duration(seconds: 4));

      //setLoading(false);

      return user!;
    } on FirebaseAuthException catch (e) {
      //return message error the firebase to user
      //setLoading(false);      
      //
      print("CODE Firebase =======>" + ((e.code)));
      print("CODE Message =======>" + (getErrorString(e.code)));
      throw Exception((getErrorString(e.code))); //(getErrorString(e.code));
    } on Exception catch (e) {
      //setLoading(false);
      print("CODE 2.1 =======>" + e.toString());
      throw Exception(e.toString()); //(getErrorString(e.code));
    }
  }

  Future<User> signUp(SignupViewModel user) async {
    //setLoading(true);
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
          email: user.email.toString(), password: user.password.toString());

      // ignore: avoid_print
      print(result.user?.uid.toString());

      //this.user = result.user;

      //await Future.delayed(const Duration(seconds: 4));

      //setLoading(false);

      return result.user!;
    } on FirebaseAuthException catch (e) {
      //return message error the firebase to user
      //setLoading(false);
      throw (getErrorString(e.code));
    } on Exception catch (e) {
      //setLoading(false);
      throw e.toString();
    }
  }

  void signOut(){
    auth.signOut();    
  }

  Future<void> create(UserModel user, String id) async {
    await firestore
        .collection('users')
        .doc(id)
        .set(user.toJson());
  }

  // Future<UserModel> get(String id) async {
  //   var user = await firestore
  //       .collection('users')
  //       .doc(id)
  //       .get();


    
    
  //   //return UserModel.fromJson(user);
  // }

  //Future<void> _loadCurrentUser() async {
  Future<UserModel?> loadCurrentUser({User? firebaseUser}) async {
    final User currentUser = firebaseUser ?? auth.currentUser!;

    print("loadCurrentUser");

    if(currentUser.uid.isNotEmpty) {      
      final docUser = await firestore.collection('users')
        .doc(currentUser.uid)
        .get();

      user = UserModel.fromDocument(docUser);

      print(user);

      //notifyListeners();
      return user;
    } else {
      print("usuário não está logado");
      return null;
    }
  }

  
}
