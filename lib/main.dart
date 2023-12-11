import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:touch_nget_ecommerce_app/pages/welcome_page.dart';
import 'pages/products_list_page.dart';
import 'services/cart_provider.dart';
import 'utils/CertReader.dart';
import 'widgets/bottom_navigation_bar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CertReader.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create:(_) => CartProvider(),
      child: Builder(builder: (BuildContext context){
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Touch & Get Shopping Cart',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: WelComePage(),
          // home: ProductsListPage(),
          // home: MyBottomNavigationBar(),
          // home: MyProductPage(),
          // home: UsersListPage(),
        );
      }) ,
    );
  }
}
