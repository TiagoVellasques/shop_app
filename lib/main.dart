
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';
import 'package:shop_app/analytics/remote_config_service.dart';
import 'package:shop_app/controllers/account_controller.dart';
import 'package:shop_app/controllers/product_controller.dart';
import 'package:shop_app/controllers/cart_controller.dart';
import 'package:shop_app/routers/navigator_service.dart';
import 'package:shop_app/routers/router.dart';
import 'package:shop_app/stores/app.store.dart';
import 'package:shop_app/view_models/signup_viewmodel.dart';
import 'package:shop_app/views/home_view.dart';
import 'package:shop_app/views/login/login_view.dart';
import 'package:shop_app/views/signup/signup_view.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'analytics/analytics.dart';
import 'services/user_service--.dart';

AppStore _appStore = AppStore();

Future<void> main() async {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp();
    //FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(false);
    FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(false);
    // set observer
    FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance);

    //RemoteConfig remoteConfig = await fetchRemoteConfig();
  } catch(e) {
    print("Failed to initialize Firebase: $e");
  }

  //await Firebase.initializeApp();
  NavigationService().setupLocator();
  
  runApp(MyApp());
  await _appStore.getUser();
  // FirebaseFirestore.instance.collection("pedidos")
  // .doc('#000001')
  // .set(
  //   {
  //     'preco' : 199.99,
  //     'usuario': 'Daniel'
  //   }
  // );
}



class MyApp extends StatelessWidget {
  MyApp() : super();

  // This widget is the root of your application.

  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Analytics>(
          create: (_) => Analytics(analytics),
        ),
        Provider<AppStore>.value(value: _appStore),
        ChangeNotifierProvider(
          lazy: false,
          create: (_) => AccountController(),
        ),
        //Provider<ProductController>.value(value: ProductController()),
        Provider(
          create: (_) => ProductController(),
          lazy: false,
        ),
        ProxyProvider<AccountController, CartController>(
          create: (_) => CartController(),
          lazy: false,
          update: (context, accountController, cartController) => 
            cartController!..updateAccount(accountController),
        )
      ],
      child: MaterialApp(
        title: 'Petshop & Cia',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.primaries.first, // Colors.blue,
        ),
        home: HomeView(),
        initialRoute: '/home',
        navigatorKey: locator<NavigationService>().navigatorKey,
        onGenerateRoute: NavigationRouter.generateRoute,
        navigatorObservers: [
          FirebaseAnalyticsObserver(analytics: analytics),
        ],
        //navigatorObservers: [observer],
        // // onGenerateRoute: (settings) {
        // //   switch (settings.name) {
        // //     case "/signup":
        // //       MaterialPageRoute(
        // //         builder: (context) => SignUpPage(),
        // //       );
        // //       break;
        // //     case "/login":
        // //       MaterialPageRoute(
        // //         builder: (context) => LoginPage(),
        // //       );
        // //       break;
        // //     case '/home':
        // //     default:
        // //       MaterialPageRoute(
        // //         builder: (context) => BasePage(),
        // //       );
        // //   }
        // //   return null;
        // // },
      ),
    );
  }
}
