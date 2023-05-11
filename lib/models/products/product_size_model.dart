class ProductSizeModel{

  ProductSizeModel.fromJson(Map<String, dynamic> json) {    
    name = json['name'] as String;
    price = json['price'] as num;           
    stock = json['stock'] as int;
  }

  late String name;
  late num price;
  late int stock;
  bool get hasStock => stock > 0;

  @override
  String toString() {
    return 'ProductSizeModel {name:$name, price:$price, stock:$stock}';
  }

}