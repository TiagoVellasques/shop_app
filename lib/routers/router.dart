
import 'package:flutter/material.dart';
import 'package:shop_app/models/products/product_model.dart';
import 'package:shop_app/routers/router_path.dart';
import 'package:shop_app/views/account/account_view.dart';
import 'package:shop_app/views/cart/cart_view.dart';
import 'package:shop_app/views/home_view.dart';
import 'package:shop_app/views/login/login_view.dart';
import 'package:shop_app/views/product_detail/product_detail_view.dart';
import 'package:shop_app/views/products/componentes/product_assessment_view.dart';
import 'package:shop_app/views/products/componentes/search_product_view.dart';
import 'package:shop_app/views/products/products_view.dart';
import 'package:shop_app/views/signup/signup_view.dart';

class NavigationRouter {

  static Route<dynamic> generateRoute(RouteSettings settings) {

    switch (settings.name) {      
      case loginRoute:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case cartRoute:
        return MaterialPageRoute(builder: (_) => CartView());
      case signupRoute:
        return MaterialPageRoute(builder: (_) => SignUpView()); 
      case accountRoute:
        return MaterialPageRoute(builder: (_) => AccountView());              
      case productsRoute:        
        
        print(settings.arguments?.toString().isEmpty);

        final filter = (settings.arguments);
       
        return MaterialPageRoute(builder: (_) => ProductsView(filter.toString()));
      case searchProductRoute:  
        
        final args = settings.arguments as String?;

        print(args?.length == null);
        
        final filter = ((args?.length == null ? null : args.toString()));
        
        return MaterialPageRoute(builder: (_) => SearchProductView(filter));
      case productDetailRoute:
        
        final product = (settings.arguments as ProductModel);

        return MaterialPageRoute(builder: (_) => ProductDetailView(product));
      case productAssessmentRoute:
        
        final id = (settings.arguments as String);

        return MaterialPageRoute(builder: (_) => ProducAssessmetView(id));

        //return MaterialPageRoute(builder: (_) => ProductsFilterView());
      //   return MaterialPageRoute(builder: (_) => ListProductPage(dept: 1,));        
      // case listProductRoute:
        
      //   final int id = int.parse(settings.arguments.toString());
      //   //final data = json.decode(settings.arguments.toString());
      //   //Map<dynamic, dynamic> json = json.(settings.arguments) as Map<dynamic, dynamic>;
        
      //   return MaterialPageRoute(builder: (_) => ListProductPage(dept: id,));
        
      //   //VeiculoModel veiculo = new VeiculoModel(id: id, placa: placa, foto: foto, local: local, data: data)
      //   //return MaterialPageRoute(builder: (_) => VeiculoDetails(veiculo: veiculoModel, status: 'Aberto',));
      case homeRoute:
      default:      
        return MaterialPageRoute(builder: (_) => HomeView());        
    }
  }
}