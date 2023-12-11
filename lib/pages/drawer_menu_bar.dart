import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:touch_nget_ecommerce_app/controllers/profile_controller.dart';
import 'package:touch_nget_ecommerce_app/models/users.dart';
import 'package:touch_nget_ecommerce_app/pages/login_page.dart';
import '../constants/urls.dart';
import '../controllers/products_controllers/my_products_controller.dart';
import '../controllers/login_controller.dart';

import 'my_product_page.dart';

class DrawerMenuBar extends StatelessWidget {
  DrawerMenuBar({super.key});

  LoginController loginController = Get.put(LoginController());

  ProfileController profileController = Get.put(ProfileController());

  MyProductsController myProductsController = Get.put(MyProductsController());

  @override
  Widget build(BuildContext context) {
    print("User List Length **********${profileController.userList.length}");
    return Obx(() {
      if (profileController.userList.isNotEmpty) {
        Users user = profileController.userList[0];

        print(loginController.isLoggedIn.value);
        return Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(
                  "${user.userName} ",
                  style: TextStyle(
                      color: Colors.cyanAccent, fontWeight: FontWeight.bold),
                ),
                accountEmail: Text(
                  "${user.userEmail}",
                  style: TextStyle(
                      color: Colors.cyanAccent, fontWeight: FontWeight.bold),
                ),
                currentAccountPicture: CircleAvatar(
                  child: ClipOval(
                    child: CachedNetworkImage(
                        imageUrl: "${Urls.apiServerBaseUrl}${user.userImage}",
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator())),
                  ),
                ),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      opacity: 0.8,
                      image: AssetImage("assets/images/saveEarth.jpg"),
                      fit: BoxFit.fill),
                ),
              ),
              ListTile(
                leading: Icon(Icons.store),
                title: const Text(
                  "My Products",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                onTap: () {
                  myProductsController.fetchMyProducts().then((value) =>
                      Get.to(MyProductPage()));
                },
              ),
              ListTile(
                leading: Icon(Icons.add_shopping_cart_outlined),
                title: const Text(
                  "My Orders",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.logout_rounded),
                title: const Text(
                  "Log Out",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                onTap: (){
                  // loginController.removeToken();
                },
              )
            ],
          ),
        );
      } else {
        return const Center(
            child: Text(
          "No Profile Found!! Login First",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            backgroundColor: Colors.amber,
          ),
        ));
      }
    });
  }
}
