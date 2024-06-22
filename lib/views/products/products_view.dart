import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/analytics/analytics.dart';
import 'package:shop_app/common/custom_drawer/custom_drawer.dart';
import 'package:shop_app/controllers/product_controller.dart';
import 'package:shop_app/models/products/product_model.dart';
import 'package:shop_app/views/products/componentes/product_list_view.dart';
import 'package:shop_app/views/products/componentes/search_product_view.dart';

class ProductsView extends StatefulWidget {
  
  late String? filter;
  static var routeName = '/products';
  
  ProductsView(this.filter);

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {  

  ProductController _productController = ProductController();

  @override
  void initState() {
    super.initState();
    getProducts();
  } 

  @override
  void didChangeDependencies() {

    super.didChangeDependencies();
    // add setCurrentScreeninstead of initState because might not always give you the
    // expected results because initState() is called before the widget
    // is fully initialized, so the screen might not be visible yet.
    //FirebaseAnalytics.instance.setCurrentScreen(screenName: "Product View");
    //context.read<Analytics>().setTrackingScreen("Product View");
    FirebaseAnalytics.instance.setCurrentScreen(screenName: "product_detail");
  }

  void getProducts() {
    _productController.getProducts(widget.filter);    
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      //key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const BackButton(
          color: Colors.red,
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        centerTitle: false,
        title: Text(
          widget.filter!.isNotEmpty ? widget.filter.toString() : 'Produtos',
          style: TextStyle(color: Colors.grey,),
        ),
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.red,
              ),
              onPressed: (){
                Navigator.of(context)
                  .pushNamed(SearchProductView.routeName.toString());                  
              },
              // onPressed: (() async {
              //   final search = await showDialog(context: context, 
              //     builder: (_) => SearchDialog());
              // }),
            ),
          ),
        ],
        elevation: 0,
        //centerTitle: true,
      ),
      body: StreamBuilder<List<ProductModel>>(
        stream: _productController.streamController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              //padding: const EdgeInsets.symmetric(horizontal: 8),
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 0,
                      mainAxisExtent: 250),
                  itemCount: snapshot.data!.length + 1,
                  itemBuilder: (context, index) {                    
                    if (index < snapshot.data!.length) {
                      final product = snapshot.data![index];            
                      return Container(                        
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: ProducListView(product: product),
                      );                      
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text("Erro ao carregar os produtos"),
                      );
                    } else {
                      //_productController.getAll();
            
                      return Container();
                      //  Padding(
                      //   padding: const EdgeInsets.symmetric(vertical: 10.0),
                      //   child: Center(child: CircularProgressIndicator()),
                      // );
                    }
                  }),
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

// class product_list_card extends StatelessWidget {
//   const product_list_card({
//     Key? key,
//     required this.product,
//   }) : super(key: key);

//   final ProductModel product;

//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       shrinkWrap: true,
//       children: <Widget>[
//         Padding(
//           padding: EdgeInsets.all(4.0),
//           child: Image.network(
//             product.images.first,
//             width: 100,
//             height: 100,
//           ),
//         ),
//         Container(
//           height: 18,
//           color: Color.fromARGB(255, 16, 62, 83),
//           //padding: EdgeInsets.all(8.0),
//           child: Center(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   Icons.star,
//                   size: 12,
//                   color: Colors.lime[700],
//                 ),
//                 Text(
//                   "PRODUTOS CAMPEÕES",
//                   style: TextStyle(
//                     fontSize: 10,
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     //fontWeight: FontWeight.w800,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Padding(
//           padding: EdgeInsets.symmetric(vertical: 8),
//           child: Text(
//             product.name,
//             style: TextStyle(
//               color: Colors.black,
//               fontSize: 14,
//             ),
//           ),
//         ),
//         Text(
//           'R\$ 299.99',
//           style: TextStyle(
//             fontSize: 12, 
//             color: Color.fromARGB(255, 122, 118, 118),
//             decoration: TextDecoration.lineThrough,
//             ),
//         ),
//         Row(
//           children: [
//             Expanded(
//               flex: 2,
//               child: Text(
//                 "R\$ 199,99",
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.black,
//                   fontWeight: FontWeight.w800,                                    
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Icon(
//                     Icons.discount,
//                     color: Color.fromARGB(255, 9, 243, 67),
//                     size: 12,
//                   ),
//                   Text(
//                     '26%',
//                     style: TextStyle(
//                       color: Color.fromARGB(255, 9, 243, 67),
//                       fontSize: 12,
//                     ),
//                     textAlign: TextAlign.end,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         Padding(
//           padding: EdgeInsets.symmetric(vertical: 2),
//           child: Text(
//             'Até em 4x de R\$ 75,00',
//             style: TextStyle(fontSize: 14, color: Colors.black),
//           ),
//         ),
//         // Container(
//         //   height: 50,
//         //   color: Colors.lime[400],
//         //   child: const Center(child: Text('Mango')),
//         // ),
//         // Container(
//         //   height: 50,
//         //   color: Colors.lime[200],
//         //   child: const Center(child: Text('Orange')),
//         // ),
//       ],
//     );
//   }
// }
