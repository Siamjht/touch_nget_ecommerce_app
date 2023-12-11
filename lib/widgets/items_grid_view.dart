import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../constants/urls.dart';
import '../models/cart_model.dart';
import '../models/products.dart';
import '../services/cart_provider.dart';
import '../services/sqlite_db_helper.dart';

class ItemsGridView extends StatelessWidget {
  final Products products;
  final int index;

  ItemsGridView({super.key, required this.products, required this.index});

  SqliteDBHelper sqliteDBHelper = SqliteDBHelper();

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.amber,
        ),
        color: Colors.cyanAccent,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              height: 300,
              width: 150,
              child: CachedNetworkImage(
                imageUrl: "${Urls.apiServerBaseUrl}${products.productImage}",
                fit: BoxFit.fill,
                placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
              ),
            ),
          ),
          Text(
            products.productName,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(r"Price: Tk" + "${products.productPrice}.00"),
          InkWell(
            onTap: () {
              var list = cart.getListItems();
              print(list);
              if(list.contains(products.productId)){
                Get.snackbar("Warning", "This product already added");
              }
              else{
                sqliteDBHelper
                    .insert(Cart(
                    id: index,
                    productId: products.productId,
                    productName: products.productName,
                    initialPrice: products.productPrice.toInt(),
                    productPrice: products.productPrice.toInt(),
                    quantity: 1,
                    image: products.productImage))
                    .then((value) {
                  cart.addListItems(products.productId.toString());
                  cart.addTotalPrice(
                      double.parse(products.productPrice.toString()));
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
    );
  }
}
