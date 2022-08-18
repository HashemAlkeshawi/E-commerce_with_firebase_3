import 'dart:developer';

import 'package:e_commerce/Providers/FirestoreProvider.dart';
import 'package:e_commerce/models/Product.dart';
import 'package:e_commerce/screens/complete_profile/Products/addNewProduct.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'complete_profile/Products/UpdateProduct.dart';

class products extends StatelessWidget {
  String catId;
  products(this.catId);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider(
      create: ((context) => FirestoreProvider.product(catId)),
      child: Scaffold(
        appBar: AppBar(),
        body: Consumer<FirestoreProvider>(builder: (context, provider, x) {
          return Container(
            height: screenHeight,
            child: Provider.of<FirestoreProvider>(context).products != null
                ? ListView.builder(
                    controller: ScrollController(keepScrollOffset: false),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      Product product = Provider.of<FirestoreProvider>(context)
                          .products![index];
                      return Stack(
                        alignment: AlignmentDirectional.topStart,
                        children: [
                          Container(
                            height: 320,
                            margin: EdgeInsets.symmetric(vertical: 6),
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: Offset(
                                      0, 2), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    SizedBox(width: 70),
                                    InkWell(
                                        onTap: () {
                                          log(provider.products![index].id!);
                                          log(provider.products!.toString());
                                          log(provider.categories.toString());
                                          provider.deleteProduct(
                                              provider.products![index].id!,
                                              provider
                                                  .categories![index].catId);
                                        },
                                        child: Icon(Icons.delete)),
                                    Spacer(),
                                    InkWell(
                                        onTap: () {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      UpdateProduct(
                                                          product, catId)));
                                        },
                                        child: Icon(Icons.update)),
                                    SizedBox(width: 70),
                                  ],
                                ),
                                SizedBox(
                                    height: 200,
                                    child: Image.network(
                                        provider.products![index].imageUrl)),

                                Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 22),
                                    child: Row(
                                      children: [
                                        Text(
                                          provider.products![index].title,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20),
                                        ),
                                        Spacer(),
                                        Text(
                                            'price: ${provider.products![index].price}'),
                                      ],
                                    )),
                                // )
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                    itemCount: Provider.of<FirestoreProvider>(context)
                        .products!
                        .length,
                  )
                : Center(child: Text('No products')
                    // Image.asset('assets/images/postsScreen.png'),
                    ),
          );
        }),
        floatingActionButton: FloatingActionButton(onPressed: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => AddNewProduct(catId)));
        }),
      ),
    );
  }
}
