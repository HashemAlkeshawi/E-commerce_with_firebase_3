import 'package:e_commerce/Providers/FirestoreProvider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../models/Product.dart';
import '../../home/home_screen.dart';
import '../../products.dart';

class UpdateProduct extends StatelessWidget {
  Product product;
  String catId;
  UpdateProduct(this.product, this.catId);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          FirestoreProvider.setProductController(product.title, product.price),
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
                      backgroundImage: NetworkImage(product.imageUrl),
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
                  await provider.updateProduct(product, catId);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => products(catId))));
                },
                child: Text("Update Product"))
          ]);
        }),
      ),
    );
  }
}
