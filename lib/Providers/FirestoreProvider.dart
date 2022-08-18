import 'dart:io';

import 'package:e_commerce/data/firestoreHelper.dart';
import 'package:e_commerce/data/storage_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import '../models/Product.dart';
import '../models/category.dart';

class FirestoreProvider extends ChangeNotifier {
  List<Category>? categories;
  List<Product>? products;

  FirestoreProvider() {
    getAllCategories();
  }
  FirestoreProvider.product(String catId) {
    getAllCategories();

    getAllProducts(catId);
  }
  FirestoreProvider.setController(String name) {
    setControllerToEdit(name);
  }
  FirestoreProvider.setProductController(String title, String price) {
    setControllerToEditProduct(title, price);
  }

  TextEditingController categoryNameController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController productTitleController = TextEditingController();
  File? selectedImage;
  File? productSelectedImage;
  addNewCategory() async {
    if (selectedImage != null) {
      String imageUrl =
          await StorageHelper.storageHelper.uploadImage(selectedImage!);
      Category category =
          Category(imageUrl: imageUrl, name: categoryNameController.text);
      await FirestoreHelper.firestoreHelper.addNewCategory(category);
      await getAllCategories();
      selectedImage = null;
    }
  }

  updateCategory(Category category) async {
    String? imageUrl;
    if (selectedImage != null) {
      imageUrl = await StorageHelper.storageHelper.uploadImage(selectedImage!);
    }
    Category newCategory = Category(
        imageUrl: imageUrl ?? category.imageUrl,
        name: categoryNameController.text);
    FirestoreHelper.firestoreHelper.updateCategory(newCategory, category.catId);
    getAllCategories();
  }

  selectImage() async {
    XFile? xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    selectedImage = File(xFile!.path);
    notifyListeners();
  }

  getAllCategories() async {
    categories = await FirestoreHelper.firestoreHelper.getAllCategories();
    notifyListeners();
  }

  deleteCategory(String catId) async {
    await FirestoreHelper.firestoreHelper.deleteCategory(catId);
    getAllCategories();
  }

  setControllerToEdit(String name) {
    categoryNameController.text = name;
    print("entered");
    notifyListeners();
  }

  addNewProduct(String catId) async {
    if (productSelectedImage != null) {
      String imageUrl =
          await StorageHelper.storageHelper.uploadImage(productSelectedImage!);
      Product product = Product(
          imageUrl: imageUrl,
          title: productTitleController.text,
          price: productPriceController.text);
      await FirestoreHelper.firestoreHelper.addNewProduct(product, catId);
      await getAllProducts(catId);
      productSelectedImage = null;
    }
  }

  updateProduct(Product product, String catId) async {
    String? imageUrl;
    if (productSelectedImage != null) {
      imageUrl =
          await StorageHelper.storageHelper.uploadImage(productSelectedImage!);
    }
    Product newProduct = Product(
        imageUrl: imageUrl ?? product.imageUrl,
        title: productTitleController.text,
        price: productPriceController.text);
    FirestoreHelper.firestoreHelper
        .updateProduct(newProduct, product.id!, catId);
    getAllProducts(catId);
  }

  selectProductImage() async {
    XFile? xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    productSelectedImage = File(xFile!.path);
    notifyListeners();
  }

  getAllProducts(String catId) async {
    products = await FirestoreHelper.firestoreHelper.getAllProducts(catId);
    notifyListeners();
  }

  deleteProduct(String productId, String catId) async {
    await FirestoreHelper.firestoreHelper.deleteProduct(productId, catId);
    getAllProducts(catId);
  }

  setControllerToEditProduct(String title, String price) {
    productTitleController.text = title;
    productPriceController.text = price;
    print("entered");
    notifyListeners();
  }
}
