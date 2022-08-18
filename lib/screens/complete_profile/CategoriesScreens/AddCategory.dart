import 'package:e_commerce/Providers/FirestoreProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../home/home_screen.dart';

class AddCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FirestoreProvider(),
      child: Scaffold(
        body: Consumer<FirestoreProvider>(builder: (context, provider, x) {
          return Column(children: [
            provider.selectedImage == null
                ? InkWell(
                    onTap: () {
                      provider.selectImage();
                    },
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.lightBlue,
                    ),
                  )
                : InkWell(
                    onTap: () {
                      provider.selectImage();
                    },
                    child: CircleAvatar(
                      radius: 50,
                      // backgroundColor: Colors.lightBlue,
                      backgroundImage: FileImage(provider.selectedImage!),
                    ),
                  ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: provider.categoryNameController,
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  await provider.addNewCategory();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: ((context) => HomeScreen())));
                },
                child: Text("Add Category"))
          ]);
        }),
      ),
    );
  }
}
