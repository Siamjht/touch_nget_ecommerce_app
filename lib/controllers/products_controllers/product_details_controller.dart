
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:get/get.dart';
import '../login_controller.dart';

import '../../constants/end_points.dart';
import '../../constants/urls.dart';
import '../../models/products.dart';
import '../../utils/CertReader.dart';

class ProductDetailsController extends GetxController{
  LoginController loginController = Get.put(LoginController());

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  RxList productsList = <Products>[].obs;
  final Dio _dio = Dio();


  Future<void> getProductDetails(String productId) async{
    var token = loginController.getToken();
    productsList.value = <Products>[];

    try{
      _dio.options.headers['Authorization'] = 'Bearer $token';
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client){
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port){
          return cert.pem == String.fromCharCodes(CertReader.getCertData());
        };
      };
      String url = "${Urls.apiServerBaseUrl}${EndPoints.products}/$productId";
      final response = await _dio.get(url);

      if(response.statusCode == 200){
        var dataList = response.data['data'];

        productsList.value.add(Products.productDetails(
            productId: dataList['id'],
            productName: dataList['name'],
            productDescription: dataList['description'],
            productPrice: dataList['price'],
            productQuantity: dataList['stock_quantity'],
            productImage: dataList['url']?? EndPoints.blankProducts));

        // for(var data in dataList){
        //   productsList.value.add(Products.productDetails(
        //       productId: data['id'],
        //       productName: data['name'],
        //       productPrice: data['price'],
        //       productDescription: data['description'],
        //       productQuantity: data['stock_quantity'],
        //       productImage: data['url']?? "${EndPoints.blankProducts}"));
        // }
      }else{
        Get.snackbar("Error", "Something went wrong");
      }
    }catch(e,s){
      Get.snackbar("Error", "$e, $s");
    }

  }

}