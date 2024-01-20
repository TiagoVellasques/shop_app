import 'package:flutter/material.dart';
import 'package:shop_app/models/users/user_model.dart';
import 'package:shop_app/repositories/account_repository.dart';
import 'package:shop_app/stores/app.store.dart';
import 'package:shop_app/view_models/signup_viewmodel.dart';

class AccountController extends ChangeNotifier {
  late AccountRepository repository;
  //AppStore store = AppStore();

  UserModel? user;

  bool _busy = false;
  bool get busy => _busy;

  AccountController() {
    print("aqui pela AccountController");
    repository = AccountRepository();
    loadCurrentUser();
  }

  Future<UserModel> create(SignupViewModel model) async {
    var user = await repository.createAccount(model);
    return user;
  }

  Future<UserModel> signIn(SignupViewModel model) async {
    try {
      busy = true;
      var user = await repository.signInAccount(model);
      busy = false;
      this.user = user;
      return user;
    } on Exception catch (e) {

      print("CODE 3 =======>" + e.toString());
      //setLoading(false);
      busy = false;
      throw Exception(e.toString());
    }
  }

  Future<UserModel?> loadCurrentUser() async {
    print("AccountController _loadCurrentUser");
    var current_user = await repository.loadCurrentUser();
    this.user = current_user;
   
    notifyListeners();

    return this.user;
  }

  void signOut(){
    repository.signOut();
    user = null;
    notifyListeners();
  }

  set busy(bool value) {
    _busy = value;
    notifyListeners();
  }
}
