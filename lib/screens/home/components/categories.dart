import 'dart:developer';

import 'package:e_commerce/Providers/FirestoreProvider.dart';
import 'package:e_commerce/screens/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../size_config.dart';
import '../../complete_profile/CategoriesScreens/UpdateCategory.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Consumer<FirestoreProvider>(builder: (x, provider, y) {
      return Container(
          width: MediaQuery.of(context).size.width,
          height: 300,
          padding: EdgeInsets.all(getProportionateScreenWidth(20)),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount:
                provider.categories == null ? 0 : provider.categories!.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              products(provider.categories![index].catId)));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: 300,
                  child: Column(
                    children: [
                      SizedBox(
                          height: 150,
                          child: Image.network(
                              provider.categories![index].imageUrl)),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        '${provider.categories![index].name}',
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                provider.deleteCategory(
                                    provider.categories![index].catId);
                              },
                              child: Icon(Icons.delete)),
                          SizedBox(
                            width: 5,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UpdateCategory(
                                            provider.categories![index])));
                              },
                              child: Icon(Icons.update))
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          )
          //  List.generate(
          //   provider.categories == null ? 0 : provider.categories!.length,
          //   (index) =>
          //
          // ),

          );
    }));
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String? icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: getProportionateScreenWidth(55),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(15)),
              height: getProportionateScreenWidth(55),
              width: getProportionateScreenWidth(55),
              decoration: BoxDecoration(
                color: Color(0xFFFFECDF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SvgPicture.asset(icon!),
            ),
            SizedBox(height: 5),
            Text(text!, textAlign: TextAlign.center)
          ],
        ),
      ),
    );
  }
}
