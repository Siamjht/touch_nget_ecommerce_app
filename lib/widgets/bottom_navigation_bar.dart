
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:touch_nget_ecommerce_app/controllers/products_controllers/products_controller.dart';
import 'package:touch_nget_ecommerce_app/controllers/users_controller.dart';

import '../pages/login_page.dart';
import '../pages/products_list_page.dart';
import '../pages/users_list_page.dart';
import 'my_app_bar.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({super.key});

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  ProductsController productsController = Get.put(ProductsController());
  UsersController usersController = Get.put(UsersController());

  @override
  void initState() {
    // TODO: implement initState
    productsController.fetchAllProducts();
    usersController.getUsersList();

    super.initState();
  }

  int myCurrentIndex = 0;
  List pages = [
    ProductsListPage(),
    UsersListPage(),
    LoginPage(),
  ];


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 25,
            offset: const Offset(8, 20)
          )]
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BottomNavigationBar(
            selectedItemColor: Colors.red,
              unselectedItemColor: Colors.amber,
              currentIndex: myCurrentIndex,
              onTap: (index) {
              setState(() {
                myCurrentIndex = index;
              });},
              items: const[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Products"),
            BottomNavigationBarItem(icon: Icon(Icons.people_alt_rounded), label: "Users"),
            BottomNavigationBarItem(icon: Icon(Icons.login_sharp), label: "Login"),
          ]),
        ),
      ),
      body: pages[myCurrentIndex],
    );
  }
}
