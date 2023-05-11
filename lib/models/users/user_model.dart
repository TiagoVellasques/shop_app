import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {

  UserModel({this.email = "", this.name = "", this.phone, this.token = ""});

  late String token;
  late String name;
  late String email;
  //String password;
  String? phone;

  late String confirmPassword;

  Map<String, dynamic> toJson(){
    return {
      'name': name,
      'email': email,
      'phone': phone
    };
  }

  UserModel.fromJson(Map<String, dynamic> json) {    
    name = json['name'];
    email = json['email'];    
    phone = json['phone'];
    token = json['token'];
  }

   UserModel.fromDocument(DocumentSnapshot document) {   
      
    
    // print(document['name'].toString());
    // print(document['email'].toString());
    // print(document['phone'].toString());
    token = document.id;
    name =  document['name'].toString();
    email = document['email'].toString();   
    phone = document['phone'].toString(); 

  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();    
  //   data['name'] = this.name;
  //   data['email'] = this.email;    
  //   data['phone'] = this.phone;
  //   data['token'] = this.token;
  //   return data;
  // }

}