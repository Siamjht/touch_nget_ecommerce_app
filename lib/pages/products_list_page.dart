
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:touch_nget_ecommerce_app/controllers/profile_controller.dart';
import 'package:touch_nget_ecommerce_app/models/products.dart';
import '../controllers/products_controllers/product_details_controller.dart';
import '../services/cart_provider.dart';
import '../widgets/items_grid_view.dart';
import '../widgets/my_app_bar.dart';
import '../controllers/products_controllers/products_controller.dart';
import 'drawer_menu_bar.dart';
import 'product_details_page.dart';

class ProductsListPage extends StatefulWidget {
  ProductsListPage({super.key});

  @override
  State<ProductsListPage> createState() => _ProductsListPageState();
}

class _ProductsListPageState extends State<ProductsListPage> {
  ProductsController productsController = Get.put(ProductsController());

  ProductDetailsController productDetailsController = Get.put(ProductDetailsController());
  ProfileController profileController = Get.put(ProfileController());
  ScrollController scrollController = ScrollController();

  Widget _buildLoadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    profileController.getProfileDetails();
    scrollController.addListener(() {
      if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
        productsController.loadMoreItems();
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    print("Product List Page Loaded;;;;;;;;;;;;;;;;");
    // final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(120.0), child: MyAppBar()),
      drawer: DrawerMenuBar(),
      body: Obx(() {
        var productsListLength = productsController.productsList.length;
        if (productsController.productsList.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
                controller: scrollController,
                itemCount: productsController.productsList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                ),
                itemBuilder: (BuildContext context, index) {
                  Products gridItem = productsController.productsList[index];
                  // print("Index of the products: $index");
                  // print("Product List Length: $productsListLength");
                  if (index + 1 < productsListLength) {
                    return GestureDetector(
                        onTap: () {
                          print(gridItem.productId);
                          productDetailsController.getProductDetails(gridItem.productId).then((value) {
                            Get.to(ProductDetailsPage(index: index));
                          });
                        },
                        child: ItemsGridView( products: gridItem,index:index ));
                  }
                  else {
                      productsController.loadMoreItems();
                      return _buildLoadingIndicator();
                    }
                    // if (index == (productsListLength - 1) &&
                    //     productsController.page.value ==
                    //         productsController.lastPage.value) {
                    // } else {
                    //   return _buildLoadingIndicator();
                    // }

                  // else {
                  //   if (index < usersListLength) {
                  //     gridItem = usersController.usersList[index];
                  //     return GestureDetector(
                  //       onTap: () {
                  //         // Get.to(ProductDetailPage());
                  //       },
                  //       child: UserGridView(users: gridItem),
                  //     );
                  //   } else {
                  //     productsController.loadMoreItems();
                  //     return _buildLoadingIndicator();
                  //   }
                  // }
                }),
          );
        }
      }
      ),
    );
  }
}
