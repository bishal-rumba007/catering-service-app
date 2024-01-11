



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MenuDataSource{
  final menuDb = FirebaseFirestore.instance.collection('menus');
  final _userDb = FirebaseFirestore.instance.collection('users');

  Future<String> createMenu({required String categoryId,
    required List<String> starterMenu, required List<String> mainCourseMenu,
    required List<String> dessertMenu, required String categoryName}) async{
    try{
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final userData = await _userDb.doc(uid).get();
      await menuDb.add({
        'userId': userData.id,
        'providerName': userData['firstName'],
        'categoryId': categoryId,
        'categoryName': categoryName,
        'starterMenu': starterMenu,
        'mainCourseMenu': mainCourseMenu,
        'dessertMenu': dessertMenu
      });
      return 'Created Menu';
    }on FirebaseException catch(err){
      return '${err.message}';
    }
  }
}