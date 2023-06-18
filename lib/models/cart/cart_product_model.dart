import 'package:shop_app/models/products/product_model.dart';
import 'package:shop_app/models/products/product_size_model.dart';

class CartProductModel {
  
  CartProductModel.fromProduct(this.product){
    productId = product.id;
    quantity = 1;
    size = product.selectedSize!.name.toString();
  }

  late String productId;
  late int quantity;
  late String size;

  ProductModel product;

  ProductSizeModel? get productSize {
    if(product == null) return null;
    return product.findSize(size);
  }

  num get unitPrice{
    if(product == null) return 0;
    return productSize?.price ?? 0;
  }

}