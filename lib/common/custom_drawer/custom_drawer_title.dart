import 'package:flutter/material.dart';


class CustomListTitle extends StatelessWidget {
  final String title;
  final Icon icon;
  final String route;

  const CustomListTitle(this.title, this.icon, this.route, {Key? key}) : super(key: key);  

  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
      onTap: () {        
          Navigator.of(context)
            .pushNamed(route.toString(),);        
        //Navigator.pushNamed(context, '/login');
        //Navigator.of(context).pushNamed('/login');
      },
      minLeadingWidth : 10,      
      title: Text(title),
      leading: (icon),
    );
  }
}

// class DrawerTitle extends StatelessWidget {

//   // ignore: use_key_in_widget_constructors
//   const DrawerTitle({ required this.iconData, required this.title });

//   final IconData iconData;
//   final String title;

//   @override
//   Widget build(BuildContext context){
//     return ListTile(      
//       leading: Icon(iconData),
//       title: Text(title,
//         style: TextStyle(
//           fontSize: 16,
//           color: Colors.grey[700]
//         ),
//       ),
//       onTap: () {
//         Navigator.pop(context);
//         //Navegar para outra página
//       },
//     );
//   }
  
// }

// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import 'package:shop_app/stores/app.store.dart';
// // import 'package:shop_app/view_models/signup_viewmodel.dart';
// // import 'package:shop_app/views/account/account_view.dart';
// // import 'package:shop_app/views/login/login_view.dart';
// // import 'package:shop_app/views/signup/signup_view.dart';

// // class CustomDrawer extends StatelessWidget {
// //   const CustomDrawer({Key? key}) : super(key: key);
// //   @override
// //   Widget build(BuildContext context) {
// //     var store = Provider.of<AppStore>(context);
// //     return Drawer(
// //       child: ListView(
// //         padding: EdgeInsets.zero,
// //         children: <Widget>[
// //           //CustomDrawerHeader(store: store),
// //           CustomListTitle("Minha conta", 
// //             Icon(Icons.person), 
// //             (store.token.isEmpty) ? LoginPage.routeName : AccountView.routeName,),
// //           CustomListTitle("Meus pedidos", 
// //             Icon(Icons.shopping_basket), 
// //             (store.token.isEmpty) ? LoginPage.routeName : AccountView.routeName,),
// //           CustomListTitle("Favoritos", 
// //             Icon(Icons.favorite), 
// //             (store.token.isEmpty) ? LoginPage.routeName : AccountView.routeName,),
// //           // ListTile(
// //           //   title: Text("Meus pedidos"),
// //           //   leading: Icon(
// //           //     Icons.shopping_basket,
// //           //   ),
// //           //   //title: "Minha conta",
// //           // ),
// //           // ListTile(
// //           //   title: Text("Favoritos"),
// //           //   leading: Icon(
// //           //     Icons.favorite,
// //           //   ),
// //           //   //title: "Minha conta",
// //           // ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // class CustomListTitle extends StatelessWidget {
// //   final String title;
// //   final Icon icon;
// //   final String route;

// //   const CustomListTitle(this.title, this.icon, this.route, {Key? key}) : super(key: key);  

// //   @override
// //   Widget build(BuildContext context) {
// //     return ListTile(
// //       onTap: () {        
// //           Navigator.of(context)
// //             .pushNamed(route.toString());        
// //         //Navigator.pushNamed(context, '/login');
// //         //Navigator.of(context).pushNamed('/login');
// //       },
// //       title: Text(title),
// //       leading: (icon),
// //     );
// //   }
// // }

