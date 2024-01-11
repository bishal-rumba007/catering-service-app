import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_riverpod/flutter_riverpod.dart';



final userProvider = FutureProvider((ref) => UserProvider().getUser());

class UserProvider{
  final _userDb = FirebaseFirestore.instance.collection('users');
  Future<types.User> getUser() async{
    final uid = FirebaseAuth.instance.currentUser!.uid;
    try{
      final data = await _userDb.doc(uid).get();
      return types.User(
        id: data.id,
        imageUrl: data['imageUrl'],
        firstName: data['firstName'],
        metadata: {
          'email': data['metadata']['email'],
          'phone': data['metadata']['phone'],
          'role': data['metadata']['role'],
        },
      );
    } on FirebaseException catch (err){
      throw '${err.message}';
    }
  }
}