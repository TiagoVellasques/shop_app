import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';
import 'package:shop_app/controllers/account_controller.dart';
import 'package:shop_app/helpers/validators.dart';
import 'package:shop_app/stores/app.store.dart';
import 'package:shop_app/view_models/signup_viewmodel.dart';
import 'package:shop_app/views/home_view.dart';
import 'package:shop_app/views/signup/signup_view.dart';
import 'package:shop_app/services/user_service--.dart';
import 'package:shop_app/models/users/user_model.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // ignore: constant_identifier_names
  static const IconData lock_rounded =
      IconData(0xf889, fontFamily: 'MaterialIcons');

  final TextEditingController emailControlller = TextEditingController();
  final TextEditingController passController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  //final _controller = new AccountController();

  final model = new SignupViewModel();
  //final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  bool submit = false;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    emailControlller.addListener(() {
      setState(() {
        submit =
            emailControlller.text.isNotEmpty && passController.text.isNotEmpty;
      });
    });
    passController.addListener(() {
      setState(() {
        submit =
            passController.text.isNotEmpty && emailControlller.text.isNotEmpty;
        // ignore: avoid_print
        print('Pass Controller $submit');
      });
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailControlller.dispose();
    passController.dispose();
    //_controller.dispose();
    submit = false;
    //model.busy = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    final store = Provider.of<AppStore>(context);

    return Scaffold(
        appBar: AppBar(
          leading: const BackButton(
            color: Colors.white,
          ),
          actions: [
            Container(padding: EdgeInsets.all(8.0), child: Icon(Icons.help)),
          ],
          title: const Text("login"),
        ),
        body: Consumer<AccountController>(
        builder: (_, accountControler, __){          
            return Form(
              key: formKey,
              child: ListView(
                // width: double.infinity,
                // height: double.infinity,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('images/logo.png',
                              width: 80, height: 80, fit: BoxFit.cover),
                          TextFormField(
                            controller: emailControlller,
                            enabled: !model.busy,
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            validator: (email) {
                              if (!emailValid(email!.toString()))
                                // ignore: curly_braces_in_flow_control_structures
                                return 'Não é um e-mail válido';
                              return null;
                            },
                            decoration: InputDecoration(
                                labelText: 'E-mail',
                                prefixIcon: IconButton(
                                    onPressed: null,
                                    icon: const Icon(Icons.email))),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: passController,
                            enabled: !model.busy,
                            autocorrect: false,
                            obscureText: true,
                            validator: (pass) {
                              if ((pass!.isEmpty || pass.length < 6)) {
                                return 'Senha inválida, mínimo 6 caracteres.';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                labelText: 'Senha',
                                prefixIcon: IconButton(
                                    onPressed: null,
                                    icon: const Icon(lock_rounded))),
                          ),
                          Container(
                            height: 40,
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              child: Container(
                                padding: EdgeInsets.zero,
                                child: const Text('Esqueci a senha?'),
                              ),
                              onTap: () {
                                // ignore: avoid_print
                                print("Tapped on container");
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          SizedBox(
                            height: 40,
                            width: double.infinity,
                            child: ElevatedButton(
                              child: 
                                (accountControler.busy)
                                  ? Center(
                                    child: Container(
                                      child: CircularProgressIndicator(
                                        backgroundColor: Colors.white,
                                      ),
                                    ),
                                  )
                                  : Text(
                                      'Entrar',
                                      style: TextStyle(color: Colors.white),
                                    ),
                              style: ElevatedButton.styleFrom(
                                  side: BorderSide(style: BorderStyle.none),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 0)),
                              // style: ButtonStyle(
                              //   backgroundColor: MaterialStateProperty.resolveWith<Color>(
                              //     (Set<MaterialState> states) {
                              //       if (states.contains(MaterialState.disabled)) {
                              //         return Theme.of(context)
                              //             .colorScheme
                              //             .primary.withAlpha(100);
                              //       }
                              //       return Theme.of(context)
                              //             .colorScheme
                              //             .primary; // Use the component's default./ Use the component's default.
                              //     },
                              //   ),
                              // ),
                              onPressed: (submit && !accountControler.busy)
                                  ? () => {
                                        if (formKey.currentState?.validate() ==
                                            true)
                                          {                                        
                                            model.email =
                                                emailControlller.text.toString(),
                                            model.password =
                                                passController.text.toString(),
                                             //setState(() {}),
                                            accountControler.signIn(model).then((data) {
                                             //setState(() {});
                                              store.setUser(
                                                  data.token,
                                                  data.name,
                                                  data.email,
                                                  data.phone.toString());
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => HomeView(),
                                                ),
                                              );
                                            }).catchError((e) {                                                                                            
                                              // ignore: avoid_print
                                              print("ERROR -------------- Code");
                                              // ignore: avoid_print
                                              print(e.toString());
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(content: Text('Falha ao entrar: usuário ou senha inválido.',), backgroundColor: Colors.red,));
                                              //print(getErrorString(e.code.toString()));
                                            }),
                                          }
                                      }
                                  : null,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 0.0),
                            alignment: Alignment.topLeft,
                            child: InkWell(
                              child: Container(
                                padding: EdgeInsets.zero,
                                child: const Text(
                                  'Cadastrar',
                                ),
                              ),
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(SignUpView.routeName);
                              },
                            ),
                          ),
                        ]),
                  ),
                ],
              ),
            );
          }
        ));
  }

  submitData() {
    if (formKey.currentState?.validate() == true) {
      // ignore: unused_local_variable
      // // final user = context
      // //     .read<UserService>()
      // //     .signIn(UserModel(
      // //         email: emailControlller.text.toString(), password: passController.text.toString()))
      // //     .then((value) => {
      // //           // ignore: todo
      // //           //TODO: FECHAR TELA DE LOGIN
      // //           ScaffoldMessenger.of(context).showSnackBar(
      // //               const SnackBar(content: Text('Dados válidos')))
      // //         })
      // //     .catchError((e) {
      // //   // ignore: avoid_print
      // //   print("ERROR -------------- Code");
      // //   // ignore: avoid_print
      // //   print(e.toString());
      // //   ScaffoldMessenger.of(context)
      // //       .showSnackBar(SnackBar(content: Text('Falha ao entrar: usuário ou senha inválido.',), backgroundColor: Colors.red,));
      // //   //print(getErrorString(e.code.toString()));
      // // });
    }
  }
}
