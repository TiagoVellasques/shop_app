import 'package:flutter/cupertino.dart';
import 'package:shop_app/models/users/user_model.dart';
import 'package:shop_app/services/user_service.dart';
import 'package:shop_app/view_models/signup_viewmodel.dart';

class AccountRepository {

  late UserService userService;

  Future<UserModel> createAccount(SignupViewModel model) async {

    userService = UserService();
    
    var data = await userService.signUp(model);

    print("retorno" + data.toString());

    var user = UserModel(
      name: model.name,
      email: data.email.toString(),
      phone: model.phone.toString(),
      token: data.uid.toString(),      
    );  

    await userService.create(user, data.uid.toString());

    return user;
      
  }

  Future<UserModel> signInAccount(SignupViewModel model) async {
    
    try {
      userService = UserService();
      var user = await userService.signIn(model);
      return user;
      
    } on Exception catch (e) {

      print("CODE 2 =======>" + e.toString());
      //setLoading(false);
      throw Exception(e.toString());
    }
   
    //var user = await userService(data.uid);

    // return UserModel(
    //   name: user.name.toString(),
    //   email: data.email.toString(),
    //   phone: user.phone.toString(),
    //   token: data.uid.toString()
    // );  
      
  }

  Future<UserModel?> loadCurrentUser() async {
    userService = UserService();
    return userService.loadCurrentUser();
  }

  void signOut(){
    userService = UserService();
    userService.signOut();
  }
}