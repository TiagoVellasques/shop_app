import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:shop_app/helpers/firebase_error.dart';
import 'package:shop_app/models/users/user_model.dart';
import 'package:shop_app/view_models/signup_viewmodel.dart';

class UserService extends ChangeNotifier {

  UserService(){
    _loadCurrentUser();
  }

  User? user;
  
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool loading = false;

  Future<UserCredential> signIn(SignupViewModel user) async {
    setLoading(true);
    try{
      UserCredential result = await auth.signInWithEmailAndPassword(
      email: user.email.toString(), password: user.password.toString());

      // ignore: avoid_print
      print(result.user?.uid.toString());
      
      this.user = result.user;

      await Future.delayed(const Duration(seconds: 4));
      
      setLoading(false);

      return result;

    }on FirebaseAuthException catch(e){
      //return message error the firebase to user
      setLoading(false);
      throw (getErrorString(e.code));
    }on Exception catch(e){
      setLoading(false);
      throw e.toString();
    }   
    
  }


  Future<UserCredential> signUp(SignupViewModel user) async {
    setLoading(true);
    try{
      UserCredential result = await auth.createUserWithEmailAndPassword(
        email: user.email.toString(), password: user.password.toString());

      // ignore: avoid_print
      print(result.user?.uid.toString());
      
      this.user = result.user;

      //await Future.delayed(const Duration(seconds: 4));
      
      setLoading(false);

      return result;

    }on FirebaseAuthException catch(e){
      //return message error the firebase to user
      setLoading(false);
      throw (getErrorString(e.code));
    }on Exception catch(e){
      setLoading(false);
      throw e.toString();
    }   
    
  }

  void setLoading(bool isLoading){
    loading = isLoading;
    notifyListeners();
  }

  void _loadCurrentUser() {

    User? currentUser = FirebaseAuth.instance.currentUser!;
    if(currentUser.uid.isNotEmpty){      
      print(currentUser.uid);

      user = currentUser;
    }else{
      print("usuário não está logado");
    }
  }

}