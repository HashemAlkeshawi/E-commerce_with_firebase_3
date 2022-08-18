import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/Product.dart';
import '../models/category.dart';

class FirestoreHelper {
  FirestoreHelper._();
  static FirestoreHelper firestoreHelper = FirestoreHelper._();
  CollectionReference<Map<String, dynamic>> categoriesCollectionReference =
      FirebaseFirestore.instance.collection('categories');
  late CollectionReference<Map<String, dynamic>> productsCollectionReference;
  getProductCollectionReference(catId) {
    productsCollectionReference = FirebaseFirestore.instance
        .collection('categories')
        .doc(catId)
        .collection('products');
  }

  addNewCategory(Category category) async {
    await categoriesCollectionReference.add(category.toMap());
  }

  Future<List<Category>> getAllCategories() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await categoriesCollectionReference.get();
    List<Category> categories = querySnapshot.docs.map((e) {
      Category category = Category.fromMap(e.data());
      category.catId = e.id;
      return category;
    }).toList();

    return categories;
  }

  updateCategory(Category category, String catId) async {
    await FirebaseFirestore.instance
        .collection('categories')
        .doc(catId)
        .update(category.toMap());
  }

  deleteCategory(String catId) async {
    await FirebaseFirestore.instance
        .collection('categories')
        .doc(catId)
        .delete();
  }

  addNewProduct(Product product, String catId) async {
    getProductCollectionReference(catId);
    await productsCollectionReference.add(product.toMap());
  }

  Future<List<Product>> getAllProducts(String catId) async {
    getProductCollectionReference(catId);
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await productsCollectionReference.get();
    List<Product> products = querySnapshot.docs.map((e) {
      Product product = Product.fromMap(e.data());
      product.id = e.id;

      return product;
    }).toList();

    return products;
  }

  updateProduct(Product product, String productId, catId) async {
    getProductCollectionReference(catId);

    await productsCollectionReference.doc(productId).update(product.toMap());
  }

  deleteProduct(String productId, String catId) async {
    getProductCollectionReference(catId);

    await productsCollectionReference.doc(productId).delete();
  }
}
