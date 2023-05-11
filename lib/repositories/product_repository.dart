import 'package:shop_app/models/products/product_model.dart';
import 'package:shop_app/services/product_service.dart';

class ProductRepository {

  late ProductService userService;

  Future<List<ProductModel>> getAll() async {
    //setLoading(true);

    userService = ProductService();
    return await userService.getAll();
    
  }  

}