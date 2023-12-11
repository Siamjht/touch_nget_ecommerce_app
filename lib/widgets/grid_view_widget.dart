import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../controllers/products_controllers/products_controller.dart';
import '../controllers/users_controller.dart';
import '../services/cart_provider.dart';
import 'items_grid_view.dart';
import 'users_grid_view.dart';

class GridViewWidget extends StatelessWidget {
  bool flag;

  GridViewWidget({super.key, required this.flag});

  UsersController usersController = Get.put(UsersController());

  // ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    // final cart = Provider.of<CartProvider>(context);
    var usersListLength = usersController.usersList.length;
    return Center(
      child: Obx(() {
        if (usersController.usersList.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
                // controller: scrollController,
                itemCount: usersListLength,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  // childAspectRatio:4,
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                ),
                itemBuilder: (context, index) {
                  var gridItem = usersController.usersList[index];
                  print("User INdex: $index");

                  // if (flag) {
                  //   if (index < (productsListLength - 1)) {
                  //     gridItem = productsController.productsList[index];
                  //     return GestureDetector(
                  //         onTap: () {
                  //           // Get.to(ProductDetailPage());
                  //         },
                  //         child:
                  //             ItemsGridView(products: gridItem, index: index));
                  //   } else {
                  //     productsController.loadMoreItems();
                  //     if(index == (productsListLength - 1) && productsController.page.value == productsController.lastPage.value){
                  //
                  //     }else{
                  //       return _buildLoadingIndicator();
                  //     }
                  //   }
                  // }

                    if (index < usersListLength) {
                      return GestureDetector(
                        onTap: () {
                          // Get.to(ProductDetailPage());
                        },
                        child: UserGridView(users: gridItem),
                      );
                    } else {
                      usersController.loadMoreUsers();
                      return _buildLoadingIndicator();
                    }
                }),
          );
        }
      }),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
