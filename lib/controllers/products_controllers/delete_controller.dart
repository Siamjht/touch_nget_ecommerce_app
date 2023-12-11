

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:get/get.dart';
import '../login_controller.dart';

import '../../constants/end_points.dart';
import '../../constants/urls.dart';
import '../../utils/CertReader.dart';

class DeleteController extends GetxController{
  LoginController loginController = Get.find<LoginController>();

  final Dio _dio = Dio();


  Future<void> deleteProduct(String productId) async{
    print(productId);
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

      String url = "${Urls.apiServerBaseUrl}${EndPoints.myProducts}/$productId?_method=DELETE";
      final response = await _dio.delete(url);

      if(response.statusCode == 200){
        print("Successfully data deleted");
        refresh();
        update();
      }else{
        Get.snackbar("Error", "Something went wrong");
      }
    }catch(e,s){
      Get.snackbar("Error", "$e, $s");
    }
  }
}