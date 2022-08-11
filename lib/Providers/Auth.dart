import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserAuth extends ChangeNotifier {
  final firebaseauthInstance = FirebaseAuth.instance;
  final usersCollection = FirebaseFirestore.instance.collection('users');

  signUp(String email, String password) async {
    try {
      await firebaseauthInstance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return firebaseauthInstance.currentUser!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  signIn(String email, String password) async {
    try {
      await firebaseauthInstance.signInWithEmailAndPassword(
          email: email, password: password);
      print("signed in");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  signOut() {}
  forgetPassword() {}

  addUser(String fullName, String phone, String email, String id) async {
    await usersCollection.doc(id).set({
      'fullName': fullName,
      'phone': phone,
      'id': id,
      'email': email,
    });
  }

  phoneVerify(String phoneNumber) async {
    await firebaseauthInstance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {},
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}
