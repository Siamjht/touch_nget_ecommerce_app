import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import '../controllers/sign_up_controller.dart';

class SignUpPage {
  SignUpController signUpController = SignUpController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool checkBoxValue = false;
  var defaultText = TextStyle(color: Colors.black);
  var linkText = TextStyle(color: Colors.indigoAccent);
  final _formKey = GlobalKey<FormState>();

  openSignUpForm(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Image.asset(
                    "assets/images/manIcon.png",
                    width: 100,
                    height: 150,
                    color: Colors.lightBlueAccent,
                  ),
                  Text(
                    "Create New Account",
                    style: TextStyle(
                      color: Colors.amber,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: nameController,
                            validator: (text){
                              if(text == null || text.isEmpty){
                                return 'Enter Some Text';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: "Full Name",
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.person),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                                labelText: "Email Address",
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.email)),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            controller: passwordController,
                            decoration: const InputDecoration(
                                labelText: "Password",
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.password)),
                            obscureText: true,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            controller: confirmPasswordController,
                            decoration: const InputDecoration(
                                labelText: "Confirm Password",
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.password)),
                            obscureText: true,
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  value: checkBoxValue,
                                  activeColor: Colors.green,
                                  onChanged: (checkBoxValue) {
                                    checkBoxValue = true;
                                  }),
                              RichText(
                                softWrap: false,
                                overflow: TextOverflow.ellipsis,
                                text: TextSpan(children: [
                                  TextSpan(
                                      style: defaultText,
                                      text: "I agree with the "),
                                  TextSpan(
                                      style: linkText,
                                      text: "Terms",
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                              launch("https://www.quora.com/What-does-terms-and-conditions-apply-mean");
                                        }),
                                  // TextSpan(
                                  //   style: defaultText,
                                  //   text: " & ",
                                  // ),
                                  // TextSpan(style: linkText, text: "Conditions")
                                ]),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 150,
                            child: ElevatedButton(
                                onPressed: (){
                                  _signUp();
                                },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.lightBlueAccent,
                                elevation: 3,
                              ),
                                child: const Text(
                                    "Sign Up",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
  void _signUp(){
    var name = nameController.text.trim();
    var email = emailController.text.trim();
    var password = passwordController.text;
    var confirmPassword = confirmPasswordController.text;
    if(password != confirmPassword  || !(password.length >= 8)){
      Get.snackbar("Error", "Password didn't matched, enter again!");
    }else{
      signUpController.signUp(name, email, password, confirmPassword);
    }
  }
}
