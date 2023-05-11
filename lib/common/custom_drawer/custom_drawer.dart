import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/common/custom_drawer/custom_drawer_header.dart';
import 'package:shop_app/common/custom_drawer/custom_drawer_title.dart';
import 'package:shop_app/stores/app.store.dart';
import 'package:shop_app/view_models/signup_viewmodel.dart';
import 'package:shop_app/views/account/account_view.dart';
import 'package:shop_app/views/login/login_view.dart';
import 'package:shop_app/views/products/products_view.dart';
import 'package:shop_app/views/signup/signup_view.dart';

class CustomDrawer extends StatelessWidget {
  
  const CustomDrawer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var store = Provider.of<AppStore>(context);
    return Drawer(
      child: ListView( 
        padding: const EdgeInsets.all(0.0),  
        //padding: EdgeInsets.zero,
        children: <Widget>[
          CustomDrawerHeader(store),
          CustomListTitle("Minha conta", 
            Icon(Icons.person), 
            (store.isLogin) ? AccountView.routeName : LoginPage.routeName,),
          CustomListTitle("Meus pedidos", 
            Icon(Icons.shopping_basket), 
            (store.token.isEmpty) ? LoginPage.routeName : AccountView.routeName,),
          // CustomListTitle("Produtos", 
          //   Icon(Icons.production_quantity_limits_outlined), 
          //   (store.token.isEmpty) ? ProductsView.routeName : ProductsView.routeName,),
          CustomListTitle("Favoritos", 
            Icon(Icons.favorite), 
            (store.token.isEmpty) ? LoginPage.routeName : AccountView.routeName,),
          // ListTile(
          //   title: Text("Meus pedidos"),
          //   leading: Icon(
          //     Icons.shopping_basket,
          //   ),
          //   //title: "Minha conta",
          // ),
          // ListTile(
          //   title: Text("Favoritos"),
          //   leading: Icon(
          //     Icons.favorite,
          //   ),
          //   //title: "Minha conta",
          // ),
        ],
      ),
    );
  }
}

// class CustomListTitle extends StatelessWidget {
//   final String title;
//   final Icon icon;
//   final String route;

//   const CustomListTitle(this.title, this.icon, this.route, {Key? key}) : super(key: key);  

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       onTap: () {        
//           Navigator.of(context)
//             .pushNamed(route.toString());        
//         //Navigator.pushNamed(context, '/login');
//         //Navigator.of(context).pushNamed('/login');
//       },
//       title: Text(title),
//       leading: (icon),
//     );
//   }
// }

