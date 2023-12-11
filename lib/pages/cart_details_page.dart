

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touch_nget_ecommerce_app/services/cart_provider.dart';
import 'package:touch_nget_ecommerce_app/services/sqlite_db_helper.dart';

import '../constants/urls.dart';
import '../models/cart_model.dart';
import '../widgets/my_app_bar.dart';

class CartDetailsPage extends StatefulWidget {
  const CartDetailsPage({super.key});

  @override
  State<CartDetailsPage> createState() => _CartDetailsPageState();
}

class _CartDetailsPageState extends State<CartDetailsPage> {
  SqliteDBHelper sqliteDBHelper = SqliteDBHelper();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<CartProvider>().getData();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar:  PreferredSize(
          preferredSize: Size.fromHeight(120.0),
          child: MyAppBar()),
      body: FutureBuilder(
          future: cart.getData(),
          builder: (context, AsyncSnapshot<List<Cart>> snapshot){
            if(snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data!.length,
                  itemBuilder: (context, index){
                  return Card(
                    elevation: 3,
                    child: ListTile(
                      leading: SizedBox(
                          child: Image(
                            image: NetworkImage(Urls.apiServerBaseUrl+snapshot.data![index].image.toString()),
                            fit: BoxFit.fitHeight,
                          )),
                      title: Text(snapshot.data![index].productName.toString()),
                      subtitle: Text("${snapshot.data![index].productPrice}"),
                      trailing: SizedBox(
                        height: 100,
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(onPressed: (){

                            }, icon: Text(
                              "-",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w500,
                              ),
                            )),

                            IconButton(onPressed: (){

                            }, icon: Icon(Icons.add))
                          ],
                        ),
                      ),
                    ),
                  );
                  }
                  );
            }
            return Text("");

          }
      ) ,
    );
  }
}

// class bottomPriceBar extends StatelessWidget {
//   final String title, value;
//   bottomPriceBar({super.key, required this.title, required this.value});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         children: [
//           Text(title, style: Theme.of(context).textTheme.subtitle2,),
//           Text(value.toString(), style: Theme.of(context).textTheme.subtitle2,)
//         ],
//       ),
//     );
//   }
// }

