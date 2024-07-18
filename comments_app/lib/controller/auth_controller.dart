


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comments_app/model/user_model.dart';
import 'package:comments_app/view/pages/home/comment_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthController extends ChangeNotifier{ 

  final  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<String> createUser({
    required BuildContext context,
    required UserModel user
  })async{
    String massage = '';
    
    try {
      
      await _firebaseAuth.createUserWithEmailAndPassword(email: user.email, password:user.password);

         var data =   _firestore.collection("users").doc(_firebaseAuth.currentUser!.uid);
         await data.set(
          user.toMap()
         ).whenComplete((){
           massage = 'User created successfully.';
           Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_)=>CommentsPage())
            , (route) => false);
           
         });




    } 
    on FirebaseAuthException catch(e){
      massage = e.code;

      return massage;
    }
    catch (e) {
      massage = 'An unexpected error occurred.';
      return massage;
      
    }
    return massage;
  }
}