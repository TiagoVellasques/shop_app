import 'package:flutter/material.dart';
import 'package:shop_app/stores/app.store.dart';
import 'package:shop_app/views/account/account_view.dart';

class CustomDrawerHeader extends StatelessWidget {
  AppStore store;
  CustomDrawerHeader(this.store, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(0.0),
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
      color: Colors.primaries.first,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: (store.isLogin)
            ? ListTile(
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                // leading: Padding(
                //   padding: const EdgeInsets.symmetric(vertical: 0.0),
                //   child: Icon(Icons.account_circle, color: Colors.white, size: 40.0,),
                // ),
                title: Text(
                  store.name,
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                subtitle: Text(
                  store.email,
                  style: TextStyle(fontSize: 14, color: Colors.white70),
                ),
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(AccountView.routeName);
                  //Navegar para outra página
                },
                trailing: Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
              )
            : ListTile(
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                leading: Icon(
                  Icons.account_circle,
                  color: Colors.white,
                  size: 40.0,
                ),
                title: Text(
                  "Faça seu login",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                subtitle: Text(
                  "ou cadastre-se.",
                  style: TextStyle(fontSize: 14, color: Colors.white70),
                ),
                onTap: () {
                  Navigator.pop(context);
                  //Navegar para outra página
                },
              ),
      ),
    );
  }
}
