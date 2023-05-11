import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_app/models/products/product_model.dart';

class ProductService {

  ProductModel? product;

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool loading = false;

  ProductService() {
    //loadCurrentUser();
  }

  Future<List<ProductModel>> getAll() async {
    //setLoading(true);
    try {      

      //var product = ProductModel();

      List<ProductModel> _allProducts = [];

      final QuerySnapshot snapshotProducts = 
        await firestore.collection('products').get();

      print("Produtos");

      _allProducts = snapshotProducts.docs.map(
          (d) => ProductModel.fromDocument(d)).toList();
        
      return _allProducts;

    } on FirebaseAuthException catch (e) {
      print("error" + e.message.toString());
      //return message error the firebase to user
      throw Exception(e.toString());
      
    } on Exception catch (e) {
      //setLoading(false);      
      print("CODE 2.1 =======>" + e.toString());
      throw Exception(e.toString()); //(getErrorString(e.code));
    }
  }

}