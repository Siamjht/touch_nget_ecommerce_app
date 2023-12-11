

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:get/get.dart';

import '../constants/end_points.dart';
import '../constants/urls.dart';
import '../models/users.dart';
import '../utils/CertReader.dart';
import 'login_controller.dart';

class ProfileController extends GetxController{
  LoginController loginController = Get.put(LoginController());

  Dio _dio = Dio();
  RxList userList = <Users> [].obs;

  Future<void> getProfileDetails() async {
    var token = loginController.getToken();
    print("Token+++++:$token");
    userList.value = <Users>[];
    try{
      _dio.options.headers['Authorization'] = 'Bearer $token';

      String url = "${Urls.apiServerBaseUrl}${EndPoints.users}/me";
      final response = await _dio.get(url);

      if(response.statusCode == 200){

        var dataList = response.data["data"];
          userList.value.add(Users.me(
              userId: dataList['id'],
              userName: dataList["name"],
              userEmail: dataList["email"],
              userMobile: dataList["mobile"],
              userImage: dataList['url'] ?? "${EndPoints.blankUsers}"));

          print("User List Length ::::::::${userList.length}");
      }else{
        Get.snackbar("Error", "Product not found!!");
      }
    } catch(e,s){
      print("Error: $e, Stacktrace: $s");
    }
  }
}