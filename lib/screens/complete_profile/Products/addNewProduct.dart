import 'package:e_commerce/Providers/FirestoreProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../home/home_screen.dart';

class AddNewProduct extends StatelessWidget {
  String catId;
  AddNewProduct(this.catId);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FirestoreProvider(),
      child: Scaffold(
        body: Consumer<FirestoreProvider>(builder: (context, provider, x) {
          return ListView(children: [
            provider.productSelectedImage == null
                ? InkWell(
                    onTap: () {
                      provider.selectProductImage();
                    },
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.lightBlue,
                    ),
                  )
                : InkWell(
                    onTap: () {
                      provider.selectProductImage();
                    },
                    child: CircleAvatar(
                      radius: 50,
                      // backgroundColor: Colors.lightBlue,
                      backgroundImage:
                          FileImage(provider.productSelectedImage!),
                    ),
                  ),
            SizedBox(
              height: 20,
            ),
            Text('Product Name'),
            TextField(
              controller: provider.productTitleController,
            ),
            Text('Product Price'),
            TextField(
              controller: provider.productPriceController,
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  await provider.addNewProduct(catId);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: ((context) => HomeScreen())));
                },
                child: Text("Add Product"))
          ]);
        }),
      ),
    );
  }
}
