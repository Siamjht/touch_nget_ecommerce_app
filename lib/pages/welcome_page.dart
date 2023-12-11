



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:touch_nget_ecommerce_app/controllers/products_controllers/products_controller.dart';
import 'package:touch_nget_ecommerce_app/pages/products_list_page.dart';
import 'package:touch_nget_ecommerce_app/widgets/bottom_navigation_bar.dart';

import 'login_page.dart';
import 'sign_up_page.dart';

class WelComePage extends StatelessWidget {
  WelComePage({super.key});
  ProductsController productsController = Get.put(ProductsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Column(
              children: [
                Text(
                  "Welcome",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Enjoy Your Shopping With \n"
                      "Touch & Get",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                ),
                Text(
                  "Do Login to get more features\n ",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontSize: 18),
                ),
              ],
            ),
            // Container(
            //   height: MediaQuery.of(context).size.height / 3,
            //   decoration: const BoxDecoration(
            //       image: DecorationImage(
            //         image: AssetImage("assets/welcome.png"),
            //       )),
            // ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Get.to(LoginPage());
                        // Navigator.push(context,MaterialPageRoute(builder: (context) => LogInPage()));
                      },
                      child: const Text(
                        'LogIn',
                        style:
                        TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
                      ),
                    ),
                    SizedBox(width: 20,),
                    ElevatedButton(
                      onPressed: () {
                        Get.to(SignUpPage());
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
                      },
                      child: const Text(
                        'Sing Up',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Text("Don't you have account? just Sign UP for free!"),
                TextButton(onPressed: () {
                  productsController.fetchAllProducts().then((value) =>
                      Get.to(MyBottomNavigationBar()));
                },
                    child: Text("Skip for now...."))
              ],
            )
          ],
        ),
      ),
    );
  }
}
