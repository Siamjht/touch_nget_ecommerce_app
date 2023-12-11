

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';
import '../utils/CertReader.dart';

class BaseService{
  var loginController = Get.find<LoginController>();
  final Dio _dio = Dio();

  baseService(){
    var token = loginController.token;

    _dio.options.headers['Authorization'] = 'Bearer $token';
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port){
        return cert.pem == String.fromCharCodes(CertReader.getCertData());
      };
    };
  }
}