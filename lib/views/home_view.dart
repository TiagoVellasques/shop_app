import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:banner_carousel/banner_carousel.dart';
import 'package:shop_app/analytics/analytics.dart';
import 'package:shop_app/analytics/remote_config_service.dart';
import 'package:shop_app/common/custom_drawer/custom_drawer.dart';
import 'package:shop_app/constants/colors.dart';
import 'package:shop_app/controllers/product_controller.dart';
import 'package:shop_app/models/category/category_model.dart';
import 'package:shop_app/models/products/product_model.dart';
import 'package:shop_app/stores/app.store.dart';
import 'package:shop_app/views/cart/cart_view.dart';
import 'package:shop_app/views/products/componentes/product_list_view.dart';
import 'package:shop_app/views/products/componentes/search_product_view.dart';
import 'package:shop_app/views/products/products_view.dart';
import 'package:shop_app/widgets/category_tab.dart';

class HomeView extends StatefulWidget {

  var routeName = '/home';

  HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  

  final PageController pageController = PageController();

  ProductController _productController = ProductController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // add setCurrentScreeninstead of initState because might not always give you the
    // expected results because initState() is called before the widget
    // is fully initialized, so the screen might not be visible yet.
    FirebaseAnalytics.instance.setCurrentScreen(screenName: "Home");
    //context.read<Analytics>().setTrackingScreen("Home");
  }

  @override
  void initState() {
    super.initState();    
    
    Future.delayed(Duration.zero, () async {
      getProducts();
    });
  }

  void getProducts() async {
    var list = await (_productController.getAll());

    //final RemoteConfig remoteConfig = await RemoteConfig.instance;
      //final RemoteConfigService remoteConfigService = RemoteConfigService(remoteConfig: remoteConfig);
      //await remoteConfigService.initialise();

    print("getProducts");
    print(list);

    
  }

  final List<CategoryModel> categories = [
      CategoryModel('', 'assets/images/pet_category_dog.png', Colors.white),
      CategoryModel('', 'assets/images/pet_category_cat.png', Colors.white),
      CategoryModel('', 'assets/images/pet_category_food.png', Colors.white),
      
    ];

  @override
  Widget build(BuildContext context) {

    const IconData shopping_cart = IconData(0xe59c, fontFamily: 'MaterialIcons');

    //var store = Provider.of<AppStore>(context);
    return PageView(
      children: <Widget>[
        Scaffold(
          drawer: SafeArea(
            child: CustomDrawer(),
          ),
          appBar: AppBar(
            title: Text("Petshop & Cia"),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.search,
                  //color: Colors.red,
                ),
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(SearchProductView.routeName.toString());
                },
              ),
              IconButton(
                icon: Icon(
                  shopping_cart,
                  //color: Colors.red,
                ),
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(CartView.routeName.toString());
                },
              ),
            ],
          ),
          //body: Container(),
          body: Consumer<ProductController>(builder: (_, productControler, __) {
            return Container(
              //width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: Carousel(
                      boxFit: BoxFit.cover,
                      images: [
                        Image.network(
                          'https://images.tcdn.com.br/img/img_prod/560844/1616685663_molecao_banner_app_royal_canin.png',
                          fit: BoxFit.fill,
                        ),
                        Image.network(
                            'https://sp-ao.shortpixel.ai/client/to_auto,q_glossy,ret_img,w_860,h_314/https://www.petdriver.com.br/blog/wp-content/uploads/2020/10/PETDRIVER_banners_blog_alt_VPSF.jpg',
                            fit: BoxFit.fill),
                        Image.network(
                            'https://i.pinimg.com/736x/85/d1/8a/85d18aedd939a3f64bb27f78ecfd29ea.jpg',
                            fit: BoxFit.fill),
                      ],
                      animationDuration: Duration(milliseconds: 1000),
                      autoplay: true,
                      dotColor: Colors.grey,
                      dotBgColor: Colors.transparent,
                      dotHorizontalPadding: 10.0,
                      dotSize: 5.0,
                      dotSpacing: 15.0,
                    ),
                  ),
                  // Expanded(                    
                  //   child: ListView.builder(
                  //     shrinkWrap: true,
                  //     scrollDirection: Axis.horizontal,
                  //     itemCount: 6,
                  //     itemBuilder: (BuildContext context, int index) => 
                  //       Card(
                  //         child: Center(child: Text('Dummy Card Text')),
                  //       ),
                  //   ),
                  // ),
                  //_productsOnOffer(),
                  CategoryTab(categories: categories),
                  // // Padding(
                  // //   padding: EdgeInsets.all(8.0),
                  // //   child: Container(
                  // //     height: 100,
                  // //     width: double.maxFinite,                      
                  // //     decoration: BoxDecoration(
                  // //       //borderRadius: BorderRadius.circular(1.0),
                  // //       border: Border.all(
                  // //         color: Colors.grey.shade300,
                  // //         width: 1,
                  // //       ),
                  // //     ),
                  // //     child: Padding(
                  // //       padding: const EdgeInsets.all(8.0),
                  // //       child: Text('Promoção 10%',),
                  // //     ),
                  // //   ),
                  // // ),
                ],
              ),
            );
          }),
        )
      ],
    );
  }

  Widget _productsOnOffer() => StreamBuilder<List<ProductModel>>(
        stream: _productController.streamController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                //controller: _scroll,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,                
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final product = snapshot.data![index];

                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ProducListView(product: product),
                  );
                });
          }

          return const Center(child: CircularProgressIndicator());
        },
      );
}

class BannerImages {
  static const String banner1 =
      "https://picjumbo.com/wp-content/uploads/the-golden-gate-bridge-sunset-1080x720.jpg";
  static const String banner2 =
      "https://cdn.mos.cms.futurecdn.net/Nxz3xSGwyGMaziCwiAC5WW-1024-80.jpg";
  static const String banner3 = "https://wallpaperaccess.com/full/19921.jpg";
  static const String banner4 =
      "https://images.pexels.com/photos/2635817/pexels-photo-2635817.jpeg?auto=compress&crop=focalpoint&cs=tinysrgb&fit=crop&fp-y=0.6&h=500&sharp=20&w=1400";

  static List<BannerModel> listBanners = [
    BannerModel(imagePath: banner1, id: "1"),
    BannerModel(imagePath: banner2, id: "2"),
    BannerModel(imagePath: banner3, id: "3"),
    BannerModel(imagePath: banner4, id: "4"),
  ];
}
