import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:touch_nget_ecommerce_app/controllers/profile_controller.dart';
import 'package:touch_nget_ecommerce_app/pages/drawer_menu_bar.dart';
import 'package:touch_nget_ecommerce_app/pages/products_list_page.dart';
import 'package:touch_nget_ecommerce_app/services/cart_provider.dart';
import 'package:touch_nget_ecommerce_app/widgets/bottom_navigation_bar.dart';
import '../constants/end_points.dart';
import '../constants/urls.dart';
import '../pages/add_products_page.dart';
import '../utils/CertReader.dart';



class LoginController extends GetxController{

  var isLoading = false.obs;
  var token = ''.obs;
  var isLoggedIn = false.obs;
  var _token = "";

  @override
  void onInit() {
    // TODO: implement onInit
    getToken();
    super.onInit();
  }

  final Dio _dio = Dio();

  Future<void> login(String username, String password) async{
    try{
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      (HttpClient client) {
        client.badCertificateCallback =
        (X509Certificate cert, String host, int port){
          return cert.pem == String.fromCharCodes(CertReader.getCertData());
        };
      };
      var url = "${Urls.apiServerBaseUrl}${EndPoints.login}";
      final response = await _dio.post(
        url, data: {
        "grant_type": "password",
        "client_id": 2,
        "client_secret":"Cr1S2ba8TocMkgzyzx93X66szW6TAPc1qUCDgcQo",
        "username": username,
        "password": password
      }
      );

      if(response.statusCode == 200){

        final Map<String, dynamic> data = response.data;

        token(data['access_token']);
        _setPrefItems();
        Get.snackbar('Success', 'Login Successful');

        isLoggedIn(true);

        // Get.offAll(() => MyBottomNavigationBar());
        Get.to(MyBottomNavigationBar());

        // Get.to(() => AddProductsPage());
        // var hiveBox = await Hive.openBox('touch&get');
        // hiveBox.put('token', token);
        // print(hiveBox.get('token'));
        // Get.to(ProductsListPage());
      }
      // print(list);
    }catch(e,s){
      Get.snackbar(
          "Error occurred", "Enter email address & password correctly!",
        snackPosition: SnackPosition.BOTTOM
      );
    }finally{
      isLoading(false);
    }
  }
  void _setPrefItems()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token.value);
  }

  void _getPrefItems()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString("token") ?? " ";
  }



  // removeToken() async{
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.remove("token");
  // }

   String getToken(){
    _getPrefItems();
    return _token;
   }
}