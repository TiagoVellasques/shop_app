import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/controllers/product_controller.dart';
import 'package:shop_app/views/products/products_view.dart';

class SearchProductView extends StatefulWidget {
  
  late String? filter;
  static var routeName = '/search_product';

  SearchProductView(this.filter);

  @override
  State<SearchProductView> createState() => _SearchProductViewState();
}

class _SearchProductViewState extends State<SearchProductView> {  

  TextEditingController _search_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {

    print(widget.filter?.isEmpty);

    //search_product.text = "Pesquisar na loja...";
    //search_controller.selection = TextSelection.fromPosition(TextPosition(offset: 0));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const BackButton(
          color: Colors.black,
        ),
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        // actions: [
        //   IconButton(
        //     color: Colors.black,
        //     iconSize: 30.0,
        //     onPressed: () {},
        //     icon: Icon(Icons.close),
        //   )
        // ],
        title: TextFormField(
          cursorColor: Colors.grey.shade700,
          cursorHeight: 20.0,
          textAlignVertical: TextAlignVertical.center,
          style: TextStyle(color: Colors.grey.shade700, fontSize: 16.0),
          autofocus: true,                    
          controller: _search_controller,
          textInputAction: TextInputAction.search,          
          decoration: InputDecoration(
            hintText: (widget.filter?.length == null ? 'O que está procurando?' : widget.filter),
            suffixIcon: IconButton(
              onPressed: _search_controller.clear,
              icon: Icon(
                Icons.clear,
                color: Colors.black,
                size: 30.0,
              ),
            ),
            border: InputBorder.none,
          ),
        ),
        elevation: 1,
        //centerTitle: true,
      ),
      body: Container(        
        child: Row(          
          children: [
            Column(
              //mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,              
              children: [
                TextButton(
                  child: Text("coleira", style: TextStyle(color: Colors.grey),),
                  onPressed: () {                    
                     Navigator.of(context)
                        .pushNamed(ProductsView.routeName.toString(), arguments: _search_controller.text); 
                  },
                ),
                TextButton(
                  child: Text("coleira antipulgas", style: TextStyle(color: Colors.grey)),
                  onPressed: () {},
                ),
                TextButton(
                  child: Text("racao premium", style: TextStyle(color: Colors.grey)),
                  onPressed: () {},
                ),
                TextButton(
                  child: Text("ração golden", style: TextStyle(color: Colors.grey)),
                  onPressed: () {},
                ),                                
                // Text("coleita antipulgas"),
                // Text("coleita antipulgas")
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
                //   child: Text("coleita antipulgas"),
                // ),
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
                //   child: Text("ração"),
                // ),
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
                //   child: Text("ração premier"),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
