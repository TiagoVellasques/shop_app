import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/controllers/account_controller.dart';
import 'package:shop_app/helpers/validators.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/services/user_service--.dart';
import 'package:shop_app/stores/app.store.dart';
import 'package:shop_app/view_models/signup_viewmodel.dart';
import 'package:shop_app/views/home_view.dart';
import '../../models/users/user_model.dart';

class AccountView extends StatefulWidget {
  static var routeName = '/account';

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController _phoneContoller = TextEditingController();

  final TextEditingController _passwordConfirmed = TextEditingController();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  //final UserModel user = UserModel();
  final model = new SignupViewModel();

  final _controller = new AccountController();

  @override
  Widget build(BuildContext context) {

    var store = Provider.of<AppStore>(context);
    _phoneContoller.text = store.phone;

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: const Text(
          'minha conta',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        //centerTitle: true,
      ),
      body: Center(
        child: Card(              
          margin: const EdgeInsets.symmetric(horizontal: 2),
          child: Form(            
            key: formKey,
            child: ListView(              
              padding: const EdgeInsets.all(10),
              //shrinkWrap: true,
              children: <Widget>[
                TextFormField(
                  initialValue: store.name,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    labelText: 'nome completo',
                  ),
                  validator: (name) {
                    if (name.toString().isEmpty)
                      return 'campo obrigatório';
                    else if (name.toString().trim().split(' ').length <= 1)
                      return 'preencha seu nome completo';
                    else if (name.toString().trim().split(' ')[1].length <= 2)
                      return 'preencha seu nome completo';
                    return null;
                  },
                  onSaved: (value) => model.name = value.toString(),
                ),
                //const SizedBox(height: 8,),
                TextFormField(
                  initialValue: store.email,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'e-mail',
                  ),
                  validator: (email) {
                    if (email.toString().isEmpty)
                      return 'campo obrigatório';
                    else if (!emailValid(email!.toString()))
                      // ignore: curly_braces_in_flow_control_structures
                      return 'não é um e-mail válido';
                    return null;
                  },
                  onSaved: (value) => model.email = value.toString(),
                ),
                //const SizedBox(height: 16,),
                TextFormField(                  
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.phone,                  
                  controller: _phoneContoller,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,                    
                    TelefoneInputFormatter(),
                  ],
                  decoration: const InputDecoration(
                    labelText: 'telefone',
                  ),
                  validator: (tel) {
                    if (tel.toString().isEmpty) return 'campo obrigatório';
                    return null;
                  },
                  onSaved: (value) {
                    //Remove mask input text
                    String phone_user = value
                        .toString()
                        .replaceAll("(", "")
                        .replaceAll(")", "")
                        .replaceAll(" ", "")
                        .replaceAll("-", "")
                        .trim();

                    model.phone = phone_user;
                  },
                ),
                //const SizedBox(height: 16,),
                TextFormField(                  
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    labelText: 'senha',
                  ),
                  obscureText: true,
                  validator: (pass) {
                    if (pass.toString().isEmpty)
                      return 'campo obrigatório';
                    else if (pass.toString().length < 6)
                      return 'senha muito curta';
                    return null;
                  },
                  onSaved: (value) => model.password = value.toString(),
                ),
                //const SizedBox(height: 8,),
                TextFormField(                  
                  controller: _passwordConfirmed,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    labelText: 'confirmar senha',
                  ),
                  obscureText: true,
                  validator: (pass) {
                    if (pass.toString().isEmpty)
                      return 'campo obrigatório';
                    else if (pass.toString().length < 6)
                      return 'senha muito curta';
                    return null;
                  },
                  //onSaved: (pass) => model.confirmPassword = pass.toString(),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 44,
                  child: ElevatedButton(
                    //color: Theme.of(context).primaryColor,
                    //disabledColor: Theme.of(context).primaryColor
                    //.withAlpha(100),
                    //textColor: Colors.white,
                    onPressed: () {
                      String phone_user = _phoneContoller.text
                          .toString()
                          .replaceAll("(", "")
                          .replaceAll(")", "")
                          .replaceAll(" ", "")
                          .replaceAll("-", "")
                          .trim();

                      print("phone" + phone_user);

                      if (formKey.currentState?.validate() == true) {
                        formKey.currentState?.save();

                        if (_passwordConfirmed.text != model.password) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(
                                      'senha e confirmar senha são diferentes.')));

                          return;
                        }

                        setState(() {});
                          _controller.create(model).then((data) {
                            setState(() {});
                            store.setUser(
                              data.token,
                              data.name,
                              data.email,
                              data.phone.toString()
                            );
                            Navigator.of(context).pushReplacementNamed(HomeView().routeName);
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => HomeView(),
                            //   ),
                            // );
                          });

                        // _controller.create(model).then((data) => {
                        //   print(data.token.toString())
                        // });
                        //submitForm(context);
                      }
                    },
                    child: const Text(
                      'Criar Conta',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void submitForm(BuildContext context) {

    

    // // final result = context
    // //     .read<UserService>()
    // //     .signUp(user)
    // //     .then((value) => {
    // //           // ignore: todo
    // //           //TODO: FECHAR TELA DE LOGIN
    // //           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    // //             content: Text('usuário cadastrado'),
    // //             backgroundColor: Colors.blue,
    // //           ))
    // //         })
    // //     .catchError((e) {
    // //   // ignore: avoid_print
    // //   print("ERROR -------------- Code");
    // //   // ignore: avoid_print
    // //   print(e.toString());
    // //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    // //     content: Text(
    // //       'Falha ao cadastrar: não foi possível realizar o cadastro. Tente novamente.',
    // //     ),
    // //     backgroundColor: Colors.red,
    // //   ));
    // // });
  }
}
