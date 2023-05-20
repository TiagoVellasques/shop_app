import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/controllers/product_controller.dart';
import 'package:shop_app/views/products/products_view.dart';

class ProducAssessmetView extends StatefulWidget {
  late String id;
  static var routeName = '/product_assessment';

  ProducAssessmetView(this.id);

  @override
  State<ProducAssessmetView> createState() => _ProducAssessmetViewState();
}

class _ProducAssessmetViewState extends State<ProducAssessmetView> {
  TextEditingController _search_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print(widget.id);

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
        elevation: 1,
        //centerTitle: true,
      ),
      body: Row(
        children: [          
          Expanded(
            child: ListView.builder(
                //physics: NeverScrollableScrollPhysics(),
                itemCount: 5 + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            //                   <--- left side
                            color: Colors.grey.shade200,
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(12.0),
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              '4.4',
                              style: TextStyle(
                                color: Colors.amber.shade400,
                                fontWeight: FontWeight.bold,
                                fontSize: 50,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            padding: const EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber.shade400,
                                      size: 22,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber.shade400,
                                      size: 22,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber.shade400,
                                      size: 22,
                                    ),
                                  ],
                                ),
                                Text(
                                  "Opiniões dos compradores",
                                  style: TextStyle(
                                      color: Colors.grey.shade700,
                                      fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            //                   <--- left side
                            color: Colors.grey.shade200,
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Wrap(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber.shade400,
                                      size: 18,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber.shade400,
                                      size: 18,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber.shade400,
                                      size: 18,
                                    ),
                                  ],
                                ),
                                Text(
                                  "Opiniões dos compradores",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 16),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  height: 20,
                                ),
                                Text(
                                  "Cliente",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 18),
                                ),
                                SizedBox(
                                  height: 10,
                                  width: double.infinity,
                                ),
                                Text(
                                  "em 15/05/2023",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 18),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }
                }),
          )

          // Container(
          //   child: Card(
          //     elevation: 1,
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.all(Radius.circular(2)),
          //     ),
          //     child: ListTile(
          //       dense: false,
          //       leading: FlutterLogo(),
          //       title: Text(
          //         "Flutter Easy Learning\nTutorial #31",
          //         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          //       ),
          //       subtitle: Text(
          //         "Instructor: Mustafa Tahir",
          //         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          //       ),
          //       trailing: Icon(Icons.arrow_forward_ios),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
