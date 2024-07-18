import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comments_app/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthController extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> createUser(
      {required BuildContext context, required UserModel user}) async {
    String massage = '';

    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: user.email, password: user.password);

      var data =
          _firestore.collection("users").doc(_firebaseAuth.currentUser!.uid);
      await data.set(user.toMap()).whenComplete(() {
        massage = 'User created successfully.';
      });
    } on FirebaseAuthException catch (e) {
      massage = e.code;

      return massage;
    } catch (e) {
      massage = 'An unexpected error occurred.';
      return massage;
    }
    return massage;
  }

  Future<String> loginUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    String massage = '';
    try {
      await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .whenComplete(() {
        massage = "Login successful";
      });
    } on FirebaseAuthException catch (e) {
      massage = e.code;
      return massage;
    } catch (e) {
      massage = 'An unexpected error occurred.';
      return massage;
    }
    return massage;
  }
}
