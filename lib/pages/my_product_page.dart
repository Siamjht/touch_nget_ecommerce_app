
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:touch_nget_ecommerce_app/controllers/products_controllers/delete_controller.dart';
import 'package:touch_nget_ecommerce_app/models/products.dart';
import 'package:touch_nget_ecommerce_app/pages/add_products_page.dart';
import '../controllers/products_controllers/my_products_controller.dart';

import '../constants/urls.dart';


class MyProductPage extends StatelessWidget {
  MyProductPage({super.key});

  MyProductsController myProductsController = Get.put(MyProductsController());
  DeleteController deleteController = Get.put(DeleteController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("My Products"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Obx(() {
        print("My product list is loading");
        if(myProductsController.myProductsList.isEmpty){
          return const Center(child: CircularProgressIndicator());
        } else{
          return ListView.builder(
            itemBuilder: (context, index) {
              Products product = myProductsController.myProductsList[index];
              return SingleChildScrollView(
                child: Card(
                  child: ListTile(
                    leading: CachedNetworkImage(
                      imageUrl:
                      "${Urls.apiServerBaseUrl}${product.productImage}",
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),),
                    title: Text(product.productName),
                    subtitle: Text("${product.productPrice}"),
                    trailing: SizedBox(
                      height: 100,
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(onPressed: (){
                            Get.to(AddProductsPage(product: product));
                          }, icon: Icon(Icons.edit)),

                          IconButton(onPressed: (){
                            openDeleteDialog(context, product.productId);
                          }, icon: Icon(Icons.delete))
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            itemCount: myProductsController.myProductsList.length,
          );
        }
      }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Get.to(AddProductsPage());
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void openDeleteDialog(
      BuildContext context, productId) async {
    await Get.defaultDialog(
      title: 'Delete Product',
      content: const Column(
        children: [
          Text("Are you sure to delete this product?"),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text('No'),
        ),
        ElevatedButton(
          onPressed: () async {
            print(productId);
            deleteController.deleteProduct(productId).then((value) =>
                myProductsController.fetchMyProducts()).then((value) => Get.back());
          },
          child: Text('Yes'),
        ),
      ],
    );
  }
}
