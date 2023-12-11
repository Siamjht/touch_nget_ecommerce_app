

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:get/get.dart';
import '../login_controller.dart';

import '../../constants/end_points.dart';
import '../../constants/urls.dart';
import '../../models/products.dart';
import '../../utils/CertReader.dart';

class MyProductsController extends GetxController{
  LoginController loginController = Get.put(LoginController());

  RxList myProductsList = <Products>[].obs;
  final Dio _dio = Dio();
  RxBool isLoading = false.obs;

  Future<void> fetchMyProducts() async{
    myProductsList.value = <Products>[];
    var token = loginController.getToken();
    try{
      _dio.options.headers['Authorization'] = 'Bearer $token';
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client){
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port){
          return cert.pem == String.fromCharCodes(CertReader.getCertData());
        };
      };
      String url = "${Urls.apiServerBaseUrl}${EndPoints.myProducts}";
      final response = await _dio.get(url);

      if(response.statusCode == 200){
        var dataList = response.data['data'];
        isLoading(true);
        for(var data in dataList){
          myProductsList.value.add(Products(
              productId: data['id'],
              productName: data['name'],
              productPrice: data['price'],
              productQuantity: data['stock_quantity'],
              productImage: data['url']?? "${EndPoints.blankProducts}"));
        }
        refresh();
        print("Successfully my products loaded");
      }else{
        Get.snackbar("Error", "Something went wrong");
      }
    }catch(e,s){
      Get.snackbar("Error", "$e, $s");
    }
  }
  @override
  void onClose(){
    super.onClose();
  }
}