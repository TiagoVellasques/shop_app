import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shop_app/models/products/product_model.dart';
import 'package:shop_app/views/product_detail/product_detail_view.dart';

Future<void> ProducAssessmetWidget(BuildContext context, ProductModel product) {
  return showModalBottomSheet<void>(
    backgroundColor: Colors.white,
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
    ),
    builder: (BuildContext context) {

      var card = Container(
        height: 150,
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: ListTile(
            dense: false,
            leading: FlutterLogo(),
            title: Text(
              "Flutter Easy Learning\nTutorial #31",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            subtitle: Text(
              "Instructor: Mustafa Tahir",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
        ),
      );


      return Container(
        height: MediaQuery.of(context).size.height * 0.89,
        padding: const EdgeInsets.only(top: 5, right: 14, left: 14, bottom: 0),
        child: Column(
          children: [
            Align(
              alignment: AlignmentDirectional.topEnd,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: InkWell(
                  child: Icon(
                    Icons.close,
                    size: 30,
                    color: Colors.grey,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
           Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: 50,
              itemBuilder: (context,index) {
                return Container(
                  height: 150,
                  child: Card(
                    elevation: 9,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: ListTile(
                      dense: false,
                      leading: FlutterLogo(),
                      title: Text(
                        "Flutter Easy Learning\nTutorial #31",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      subtitle: Text(
                        "Instructor: Mustafa Tahir",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                );
              },
            ),
          ),
            // Container(
            //   height: MediaQuery.of(context).size.height * 0.75,
            //   child: Scrollbar(
            //     //thickness: 8, //width of scrollbar
            //     radius: Radius.circular(5), //corner radius of scrollbar
            //     scrollbarOrientation: ScrollbarOrientation.right,
            //     child: SingleChildScrollView(
            //       child: Column(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           card,
            //           // Container(
            //           //   height: 80,
            //           //   width: double.infinity,
            //           //   color: Colors.orange,
            //           // ),
            //           card,
            //           card,                      
            //           card,
            //           card,                      
            //           Center(
            //             child: TextField(
            //               decoration: InputDecoration(
            //                 border: OutlineInputBorder()
            //               ),
            //             ),
            //           ),
            //         ],                      
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      );
    },
  );
}
