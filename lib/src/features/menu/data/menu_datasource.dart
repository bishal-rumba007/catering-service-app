



import 'package:catering_service_app/src/features/menu/domain/models/menu_model.dart';
import 'package:catering_service_app/src/features/review/domain/review_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class MenuDataSource{
  final menuDb = FirebaseFirestore.instance.collection('menus');
  final _userDb = FirebaseFirestore.instance.collection('users');
  final _categoryDb = FirebaseFirestore.instance.collection('categories');
  final _reviewDb = FirebaseFirestore.instance.collection('reviews');
  final uid = FirebaseAuth.instance.currentUser!.uid;

  Future<String> createMenu({required String categoryId, required String price,
    required List<String> starterMenu, required List<String> mainCourseMenu,
    required List<String> dessertMenu, required String categoryName, String? menuDescription}) async{
    try{
      final userData = await _userDb.doc(uid).get();
      await menuDb.add({
        'userId': userData.id,
        'providerName': userData['firstName'],
        'price': price,
        'categoryId': categoryId,
        'categoryName': categoryName,
        'starterMenu': starterMenu,
        'mainCourseMenu': mainCourseMenu,
        'dessertMenu': dessertMenu,
        'menuDescription': menuDescription ?? "",
      });
      return 'Created Menu';
    }on FirebaseException catch(err){
      return '${err.message}';
    }
  }

  Stream<List<Menus>> getMenu() {
    return _userDb.doc(uid).snapshots().asyncMap((userData) async {
      final userId = userData.id;
      final response = await menuDb
          .where('userId', isEqualTo: userId)
          .get();
      final menusList = await Future.wait(
        response.docs.map(
              (doc) async {
            final json = doc.data();
            final categoryImage = await getCategoryImage(json['categoryId']);
            final user = await getUserDetail(json['userId']);
            final reviews = await getReview(doc.id);
            return Menus.fromJson({
              ...json,
              'categoryImage': categoryImage,
              'menuId': doc.id,
              'user': user,
              'reviews': reviews,
            });
          },
        ),
      );
      return menusList;
    });
  }

  Future<types.User> getUserDetail(String userId) async {
    try {
      final snapshot = await _userDb.doc(userId).get();
      if (snapshot.exists) {
        final json = snapshot.data() as Map<String, dynamic>;
        return types.User(
          id: snapshot.id,
          firstName: json['firstName'],
          metadata: {
            'deviceToken': json['metadata']['deviceToken'],
            'email': json['metadata']['email'],
            'phone': json['metadata']['phone'],
            'role': json['metadata']['role'],
          },
        );
      } else {
        throw 'User not found';
      }
    } on FirebaseException catch (error) {
      throw '$error';
    }
  }

  Future<String?> getCategoryImage(String categoryId) async {
    try {
      final categorySnapshot = await _categoryDb.doc(categoryId).get();

      if (categorySnapshot.exists) {
        return categorySnapshot['imageUrl'];
      } else {
        return null;
      }
    } on FirebaseException catch (err) {
      throw '$err';
    }
  }

  Future<List<ReviewModel>> getReview(String menuId) async {
    try {
      final response = await _reviewDb.where('menuId', isEqualTo: menuId).get();
      final reviewList = await Future.wait(
        response.docs.map(
              (doc) async {
            final json = doc.data();
            return ReviewModel.fromJson({
              ...json,
              'reviewId': doc.id,
            });
          },
        ),
      );
      return reviewList;
    } on FirebaseException catch (err) {
      throw '$err';
    }
  }


  Future<String> updateMenu({
    required String menuId,
    required String categoryId,
    required String price,
    required List<String> starterMenu,
    required List<String> mainCourseMenu,
    required List<String> dessertMenu,
    required String categoryName,
  }) async {
    try {
      final userData = await _userDb.doc(uid).get();
      await menuDb.doc(menuId).update({
        'userId': userData.id,
        'providerName': userData['firstName'],
        'price': price,
        'categoryId': categoryId,
        'categoryName': categoryName,
        'starterMenu': starterMenu,
        'mainCourseMenu': mainCourseMenu,
        'dessertMenu': dessertMenu,
      });
      return 'Menu Updated';
    } on FirebaseException catch (err) {
      return '${err.message}';
    }
  }


  Future<String> deleteMenu(String menuId) async {
    try {
      await menuDb.doc(menuId).delete();
      return 'success';
    } on FirebaseException catch (err) {
      throw '$err';
    }
  }
}