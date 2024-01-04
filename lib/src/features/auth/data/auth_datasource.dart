import 'package:catering_service_app/src/app.dart';
import 'package:catering_service_app/src/features/auth/screens/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;



class AuthDataSource{

  final userDb = FirebaseFirestore.instance.collection('users');

  Future<String> userSignup({
    required String fullName, required String email,
    required String phoneNumber, required String password}) async{

    try{
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password
      );

      await FirebaseChatCore.instance.createUserInFirestore(
        types.User(
            firstName: fullName,
            id: credential.user!.uid,
            metadata: {
              'email': email,
              'phone': phoneNumber,
            }
        ),
      );
      return 'Registration Successful';
    } on FirebaseAuthException catch(err){
      return '${err.message}';
    }
  }

  Future<String> userLogin({required String username, required String password}) async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: username,
          password: password
      );
      return 'Login Successful';
    } on FirebaseAuthException catch(err){
      return '${err.message}';
    }

  }

  Future<String> userLogout() async{
    try{
      await FirebaseAuth.instance.signOut();
      navigatorKey.currentState?.pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => const LoginScreen(),
          ), (route) => false);
      return 'success';
    } on FirebaseAuthException catch(err){
      return '${err.message}';
    }
  }

}