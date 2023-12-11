
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:touch_nget_ecommerce_app/controllers/products_controllers/products_controller.dart';
import 'package:touch_nget_ecommerce_app/controllers/users_controller.dart';

import '../widgets/grid_view_widget.dart';
import '../widgets/my_app_bar.dart';
import 'drawer_menu_bar.dart';

class UsersListPage extends StatelessWidget {
  UsersListPage({super.key});
  UsersController usersController = Get.put(UsersController());


  @override
  Widget build(BuildContext context) {
    usersController.getUsersList();
    return Scaffold(
        appBar: PreferredSize(preferredSize: Size.fromHeight(120.0),
            child: MyAppBar()),
        drawer: DrawerMenuBar(),
        body: GridViewWidget(flag: false),
    );
  }
}
