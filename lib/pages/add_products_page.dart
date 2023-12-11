import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:touch_nget_ecommerce_app/models/products.dart';

import '../controllers/products_controllers/upload_controller.dart';


class AddProductsPage extends StatefulWidget {
  Products? product;
  AddProductsPage({super.key, this.product});

  @override
  State<AddProductsPage> createState() => _AddProductsPageState();
}

class _AddProductsPageState extends State<AddProductsPage> {
  XFile? image;

  final ImagePicker picker = ImagePicker();

  Future getImage(ImageSource media) async{
    var img = await picker.pickImage(source: media);
    setState(() {
      image = img;
      print("Image path ${image?.path}");
    });
  }

  void myAlert(){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10)),
            title: Text("Please choose a media to select"),
            content: Container(
              height: MediaQuery.of(context).size.height/6,
              child: Column(
                children: [
                  ElevatedButton(onPressed: (){
                    Navigator.pop(context);
                    getImage(ImageSource.gallery);
                  },
                      child: const Row(
                        children: [
                          Icon(Icons.image),
                          Text('From Gallery'),
                        ],
                      )),
                  ElevatedButton(onPressed: (){
                    Navigator.pop(context);
                    getImage(ImageSource.camera);
                  }, child: const Row(
                    children: [
                      Icon(Icons.camera),
                      Text("From Camera"),
                    ],
                  )),
                ],
              ),
            ),
          );
        });
  }
  UploadProductsController uploadProductsController = UploadProductsController();
  TextEditingController productsNameController = TextEditingController();
  TextEditingController productsPriceController = TextEditingController();
  TextEditingController productsDescripController = TextEditingController();
  TextEditingController productsQuantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Products Add to the Server"),),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              ElevatedButton(
                  onPressed: (){
                    myAlert();
                  }, child: Text("Upload Photo"),
              ),
              SizedBox(
                height: 10,
              ),
              image != null
                 ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    File(image!.path),
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                  ),
                ),
              ): Text("No Image"),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    TextFormField(
                      controller: productsNameController,
                      decoration: const InputDecoration(labelText: "Products Name"),
                    ),
                    TextFormField(
                      controller: productsPriceController,
                      decoration: const InputDecoration(labelText: "Products Price"),
                    ),
                    TextFormField(
                      controller: productsDescripController,
                      decoration: const InputDecoration(labelText: "Products Description"),
                    ),
                    TextFormField(
                      controller: productsQuantityController,
                      decoration: const InputDecoration(labelText: "Products Quantity"),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            var imagePath = image!.path;
            var productsName = productsNameController.text;
            var productsPrice = productsPriceController.text;
            var productsDescription = productsDescripController.text;
            var productsQuantity = productsQuantityController.text;
            uploadProductsController.uploadProducts(
              imagePath, productsName, productsPrice, productsDescription, productsQuantity
            );
          },
        child: const Icon(Icons.add),
      ),
    );
  }
}
