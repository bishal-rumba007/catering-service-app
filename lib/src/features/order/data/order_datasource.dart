

import 'package:catering_service_app/src/features/order/domain/models/order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrderDataSource{
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final _userDb = FirebaseFirestore.instance.collection('users');
  final _categoryDb = FirebaseFirestore.instance.collection('categories');
  final _orderDb = FirebaseFirestore.instance.collection('orders');


  Stream<List<OrderModel>> getOrdersStream() {
    try {
      return _userDb.doc(uid).snapshots().asyncMap((userData) async {
        final userId = userData.id;

        final response = await _orderDb
            .where('catererId', isEqualTo: userId)
            .get();

        final orderList = await Future.wait(response.docs.map((doc) async {
          final json = doc.data();
          final categoryImage = await getCategoryImage(json['categoryId']);
          return OrderModel.fromJson({
            ...json,
            'orderId': doc.id,
            'categoryImage': categoryImage,
          });
        }));

        return orderList;
      });
    } on FirebaseException catch (error) {
      throw '$error';
    }
  }

  Future<String?> getCategoryImage(String categoryId) async {
    try {
      final categoriesSnapshot = await _categoryDb.doc(categoryId).get();

      if (categoriesSnapshot.exists) {
        final matchingCategory = categoriesSnapshot.data();
        return matchingCategory?['imageUrl'];
      } else {
        return null;
      }
    } on FirebaseException catch (err) {
      throw '$err';
    }
  }

  Future<String> acceptOrder({required String orderId}) async {
    try {
      await _orderDb.doc(orderId).update({
        'orderStatus': OrderStatus.accepted.index,
      });
      return 'Order accepted';
    } on FirebaseException catch (err) {
      throw '$err';
    }
  }

  Future<String> completeOrder({required String orderId}) async {
    try {
      await _orderDb.doc(orderId).update({
        'orderStatus': OrderStatus.completed.index,
      });
      return 'Order completed';
    } on FirebaseException catch (err) {
      throw '$err';
    }
  }

  Future<String> rejectOrder({required String orderId}) async {
    try {
      await _orderDb.doc(orderId).update({
        'orderStatus': OrderStatus.rejected.index,
      });
      return 'Order rejected';
    } on FirebaseException catch (err) {
      throw '$err';
    }
  }

}