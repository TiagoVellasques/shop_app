import 'package:mobx/mobx.dart';
import 'package:shop_app/controllers/account_controller.dart';
part 'app.store.g.dart';

class AppStore = _AppStore with _$AppStore;
late AccountController account_controller;

abstract class _AppStore with Store {
  // @observable 
  @observable 
  bool isLogin = false;

  @observable
  String token = "";
  @observable
  String name = "";
  @observable
  String email = "";
  @observable
  String phone = "";   

  @action
  void setUser(String _token, String _name, String _email, String _phone){

    isLogin = _token.isNotEmpty ? true : false;

    token = _token;
    name = _name;
    email = _email;
    phone = _phone;
  }

  @action
  Future getUser() async {    
    account_controller = AccountController();
    var user = await account_controller.loadCurrentUser();
    setUser(user!.token,
      user.name,
      user.email,
      user.phone.toString());

    isLogin = user.token.isNotEmpty? true : false;
  }
}