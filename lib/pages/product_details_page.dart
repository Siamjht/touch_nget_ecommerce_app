import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:touch_nget_ecommerce_app/services/sqlite_db_helper.dart';
import '../controllers/products_controllers/product_details_controller.dart';
import '../models/cart_model.dart';
import '../models/products.dart';


import '../constants/urls.dart';
import '../services/cart_provider.dart';
import '../widgets/my_app_bar.dart';
import 'drawer_menu_bar.dart';

class ProductDetailsPage extends StatelessWidget {
  final int index;
  ProductDetailsPage({super.key, required this.index});

  ProductDetailsController productDetailsController = Get.put(ProductDetailsController());
  SqliteDBHelper sqliteDBHelper = SqliteDBHelper();

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(120.0), child: MyAppBar()),
      drawer: DrawerMenuBar(),
      body: Obx(() {
        if(productDetailsController.productsList.isNotEmpty){
          Products product = productDetailsController.productsList[0];
          return SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Container(

                    width: (MediaQuery.of(context).size.width) / 1.5,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.amber,
                      ),
                      color: Colors.cyanAccent,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        CachedNetworkImage(
                          imageUrl: "${Urls.apiServerBaseUrl}${product.productImage}",
                          fit: BoxFit.fill,
                          placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                        ),
                        Text(
                          product.productName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                                "Description: ",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16
                              )
                            ),
                            Text(
                              "${product.productDescription}",
                            ),
                          ],
                        ),
                        Text(r"Price: Tk" + "${product.productPrice}.00"),
                        InkWell(
                          onTap: () {
                            var list = cart.getListItems();
                            print(list);
                            if(list.contains(product.productId)){
                              Get.snackbar("Warning", "This product already added");
                            }
                            else{
                              sqliteDBHelper
                                  .insert(Cart(
                                  id: index,
                                  productId: product.productId,
                                  productName: product.productName,
                                  initialPrice: product.productPrice.toInt(),
                                  productPrice: product.productPrice.toInt(),
                                  quantity: 1,
                                  image: product.productImage))
                                  .then((value) {
                                cart.addListItems(product.productId.toString());
                                cart.addTotalPrice(
                                    double.parse(product.productPrice.toString()));
                                cart.addCounter();
                              }).onError((error, stackTrace) {
                                print(error.toString());
                              });
            
                            }
                          },
                          child: Container(
                            height: 35,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.lightBlueAccent),
                            child: Center(child: Text('Add cart')),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }
        else{
          return const Text("Product List is empty");
        }
      }),
    );
  }
}
