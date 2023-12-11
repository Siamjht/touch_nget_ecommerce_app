

import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:dio/io.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';

import '../../utils/CertReader.dart';
import '../login_controller.dart';
 
class UploadProductsController{

  var loginController = Get.find<LoginController>();
  final dio.Dio _dio = dio.Dio();

  uploadProducts(
      String imagePath, String productsName, String productsPrice,
      String productsDescription, String productsQuantity ) async{
    try {
      var token = loginController.getToken();
      _dio.options.headers['Authorization'] = 'Bearer $token';
      print("${_dio.options.headers['Authorization']}");

      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port){
          return cert.pem == String.fromCharCodes(CertReader.getCertData());
        };
      };

      // baseService.baseService();

      dio.FormData formData = dio.FormData.fromMap({
        'name': productsName,
        'price': productsPrice,
        'description': productsDescription,
        'image': await dio.MultipartFile.fromFile(imagePath,
            contentType: MediaType("image", "jpg")),
        'stock_quantity': productsQuantity,
      });

      var response = await _dio.post('https://demo.alorferi.com/api/my-products', data: formData);
      print('Response: ${response.data}');
      if(response.statusCode == 200){
        Get.snackbar("", "Product Successfully Uploaded");
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}