
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:dio/io.dart';
import 'package:touch_nget_ecommerce_app/pages/products_list_page.dart';
import '../../constants/end_points.dart';
import '../../constants/urls.dart';
import '../../models/products.dart';
import '../../utils/CertReader.dart';
import '../../widgets/bottom_navigation_bar.dart';
import '../login_controller.dart';
// import 'package:http/http.dart' as http;

class ProductsController extends GetxController {

  final dio.Dio _dio = dio.Dio();
  RxList productsList = <Products>[].obs;

  RxInt page = 1.obs;
  RxBool isLoading = false.obs;
  RxInt lastPage = 0.obs;
  var token = '';


  @override
  void onInit() {
    fetchAllProducts();
    super.onInit();
  }

  void loadMoreItems(){
    fetchAllProducts();
  }
  Future<void> fetchAllProducts() async {
    if(isLoading.value) return;
    try {
      isLoading.value = true;
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port){
          return cert.pem == String.fromCharCodes(CertReader.getCertData());
        };
      };
      String url = "${Urls.apiServerBaseUrl}${EndPoints.products}?page=${page.value}";
      final response = await _dio.get(url);

      isLoading.value = false;
      if(response.statusCode == 200){
        var dataList = response.data['data'];

        for(var data in dataList){
          productsList.value.add(Products(
              productId: data['id'],
              productName: data['name'],
              productPrice: data['price'],
              productQuantity: data['stock_quantity'],
              productImage: data['url']?? "${EndPoints.blankProducts}"));
        }
        lastPage(response.data["meta"]["last_page"]);

        if(page == lastPage){
          isLoading.value = true;
        }
        else{
          page++;
        }
        print("All Products are taken in list]]]]]]]]]]]]]]]]]]]]]");
        // refresh();
        // update();
      }else{
        Get.snackbar("Error", "Product not found!!");
      }
      Get.to(MyBottomNavigationBar());
    } catch (e, s) {
      print("Error, An error occurred during product load $e & Stacktrace:  $s ");
    }
  }
}
