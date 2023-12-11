import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:get/get.dart';


import '../constants/end_points.dart';
import '../constants/urls.dart';
import '../models/users.dart';
import '../utils/CertReader.dart';

class UsersController extends GetxController{

  Dio _dio = Dio();

  RxList usersList = <Users> [].obs;
  RxInt page = 1.obs;
  RxBool isLoading = false.obs;
  RxInt lastPage = 0.obs;

  @override
  void onInit(){
    getUsersList();
    super.onInit();
   }

  Future<void> getUsersList() async {
    if(isLoading.value) return;
    try{
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port){
          return cert.pem == String.fromCharCodes(CertReader.getCertData());
        };
      };
      String url = "${Urls.apiServerBaseUrl}${EndPoints.users}?page=${page.value}";
      final response = await _dio.get(url);

      if(response.statusCode == 200){
        var dataList = response.data['data'];
        for(var data in dataList){
          usersList.value.add(Users(
              userId: data['id'],
              userName: data["name"],
              userImage: data['url'] ?? "${EndPoints.blankUsers}"));
        }
        lastPage(response.data['meta']["last_page"]);
        if(page == lastPage){
          isLoading(true);
        }
        page++;

      }else{
        Get.snackbar("Error", "Product not found!!");
      }
    } catch(e,s){
      Get.snackbar("Error", "An error occurred during User list load");
      print(e);
    }
  }
  void loadMoreUsers(){
    getUsersList();
  }
}

