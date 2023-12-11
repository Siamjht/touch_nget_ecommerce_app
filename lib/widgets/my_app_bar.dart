import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:touch_nget_ecommerce_app/pages/cart_details_page.dart';
import '../services/cart_provider.dart';
import '../utils/colors.dart';
import 'big_text.dart';
import 'small_text.dart';
import 'package:badges/badges.dart' as badges;

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  MyAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(
        color: AppColors.buttonColor,
        size: 30.0,
      ),
      backgroundColor: AppColors.appColor,
      toolbarHeight: 120.0,
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BigText(
            text: "Touch & Get",
            color: AppColors.mainColor,
          ),
          SmallText(
            text: "Shopping Cart",
            color: AppColors.textColor2,
          ),
        ],
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 20 ),
          child: InkWell(
            onTap: (){
              Get.to(const CartDetailsPage());
            },
            child: Center(
              child: badges.Badge(
                badgeColor: Colors.cyan,
                badgeContent: Consumer<CartProvider>(
                  builder: (context, value, child){
                    return Text(value.getCounter().toString());
                  },
                ),
                animationDuration: Duration(milliseconds: 300),
                child: Icon(Icons.shopping_cart_sharp),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
