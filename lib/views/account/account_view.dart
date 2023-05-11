import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/controllers/account_controller.dart';
import 'package:shop_app/helpers/validators.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:provider/provider.dart';
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

    List<Text> manufacturers = [
      Text(
        'Toyota',
      ),
      Text(
        'VolksWagen',
      ),
      Text(
        'Nissan',
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const BackButton(
          color: Colors.red,
        ),
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        // title: const Text(
        //   'Meus dados',
        //   style: TextStyle(color: Colors.white),
        // ),
        elevation: 0,
        //centerTitle: true,
      ),
      body: Container(
        child: ListView(
          padding: const EdgeInsets.all(0.0),
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 12.0),
              child: Text(
                "Meus dados",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Card(
                      child: ListTile(
                          title: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8.0,
                            ),
                            child: Text(
                              store.name,
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                          subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                child: Text(store.email),
                                height: 22.0,
                              ),
                              SizedBox(
                                child: Text(store.phone.toString()),
                                height: 22.0,
                              ),
                              SizedBox(
                                child: Text("048.###.###-##"),
                                height: 22.0,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "alterar e-mail",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.primaries.first),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "alterar senha",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.primaries.first),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          trailing: Icon(
                            Icons.edit,
                            color: Colors.primaries.first,
                          ))),
                  Card(
                    child: ListTile(
                      title: Container(
                        decoration: BoxDecoration(
                            border: Border(
                          bottom: BorderSide(
                            //                   <--- left side
                            color: Color.fromARGB(223, 209, 209, 203),
                            width: 1.0,
                          ),
                        )),
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(children: [
                          Expanded(
                              child: Text(
                            "Endereços",
                            style: TextStyle(fontSize: 18),
                          )),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              TextButton(
                                //color: Theme.of(context).primaryColor,
                                //disabledColor: Theme.of(context).primaryColor
                                //.withAlpha(100),
                                //textColor: Colors.white,
                                onPressed: () {},
                                child: Text(
                                  'ver todos',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.primaries.first),
                                ),
                              ),
                              // Text(
                              //   "ver todos",
                              //   style: TextStyle(
                              //       fontSize: 16, color: Colors.primaries.first),
                              // ),
                            ],
                          )),
                        ]),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              child: Text("Rua Dr. Bley Zorning, 2888"),
                              height: 22.0,
                            ),
                            SizedBox(
                              child:
                                  Text("Boqueirão, Curitiba - PR | 81000-000"),
                              height: 22.0,
                            ),
                            SizedBox(
                              child: Text("Raquel Matias de Souza"),
                              height: 22.0,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "editar",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.primaries.first),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "excluir",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black38),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // trailing: Text(
                      //   "ver todos",
                      //   style: TextStyle(fontSize: 14),
                      // ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                      child: Row(
                        children: [
                          TextButton(
                            //color: Theme.of(context).primaryColor,
                            //disabledColor: Theme.of(context).primaryColor
                            //.withAlpha(100),
                            //textColor: Colors.white,
                            onPressed: () {},
                            child: Text(
                              '+ cadastrar novo endereço',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.primaries.first),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),                 
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 30.0),
                    height: 44,
                      width: MediaQuery.of(context).size.width,
                        child:  ElevatedButton(
                        //color: Theme.of(context).primaryColor,
                        //disabledColor: Theme.of(context).primaryColor
                        //.withAlpha(100),
                        //textColor: Colors.white,
                        onPressed: () {
                          print("sair da conta");
                          _controller.signOut();
                          store.isLogin = false;
                          Navigator.of(context)
                              .pushReplacementNamed(HomeView().routeName);
                        },
                        child: const Text(
                          'sair da conta',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  
                ],
              ),
            ),
          ],
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
