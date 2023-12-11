
import 'package:dio/dio.dart';

import 'package:get/get.dart';

import '../constants/end_points.dart';
import '../constants/urls.dart';
import '../pages/login_page.dart';




class SignUpController extends GetxController{
  Dio dio = Dio();

  signUp(String name, String email, String password, String confirmPassword) async{
    print("$name, $email, $password, $confirmPassword");
    try{
      var response = await dio.post(
          '${Urls.apiServerBaseUrl}${EndPoints.signUP}',
          data: {
            "name" : name,
            "email" : email,
            "password" : password,
            "password_confirmation" : confirmPassword,
          });
      if(response.statusCode == 200){
        Get.snackbar(
            "Success:", "Your new account has been created.",
          snackPosition: SnackPosition.BOTTOM,
        );
        Get.to(LoginPage());
      }else{
        Get.snackbar(
            "Error:", "Something went wrong",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }catch(e,s){
      Get.snackbar(
          "Error Occurred:", "$e",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}