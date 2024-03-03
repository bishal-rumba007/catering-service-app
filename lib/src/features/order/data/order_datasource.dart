

import 'package:catering_service_app/src/features/order/domain/models/order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class OrderDataSource{
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final _userDb = FirebaseFirestore.instance.collection('users');
  final _categoryDb = FirebaseFirestore.instance.collection('categories');
  final _orderDb = FirebaseFirestore.instance.collection('orders');
  final _notificationDb = FirebaseFirestore.instance.collection('notifications');

  Stream<List<OrderModel>> getOrdersStream() {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    try {
      final data =
      _orderDb.where('catererId', isEqualTo: uid).snapshots();
      final response = data.asyncMap((event) async {
        final data = Future.wait(event.docs.map((e) async {
          final json = e.data();
          final categoryImage = await getCategoryImage(json['categoryId']);
          final userData = await getUserDetail(json['orderInfo']['customerId']);
          return OrderModel.fromJson({
            ...json,
            'orderId': e.id,
            'categoryImage': categoryImage,
            'user': userData,
          });
        }).toList());
        return data;
      });
      return response;
    } on FirebaseException catch (error) {
      throw '$error';
    }
  }

  Stream<OrderModel> getOrderDetail(String orderId) {
    try {
      return _orderDb.doc(orderId).snapshots().asyncMap((orderData) async {
        final json = orderData.data();
        final categoryImage = await getCategoryImage(json!['categoryId']);
        final userData = await getUserDetail(json['orderInfo']['customerId']);
        return OrderModel.fromJson({
          ...json,
          'orderId': orderData.id,
          'categoryImage': categoryImage,
          'user': userData,
        });
      });
    } on FirebaseException catch (error) {
      throw '$error';
    }
  }

  Future<types.User> getUserDetail(String userId) async{
    try{
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
    }on FirebaseException catch (error) {
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
      return 'Order Rejected';
    } on FirebaseException catch (err) {
      throw '$err';
    }
  }

  Future<String> rejectNotification({required OrderModel orderModel, required String reason}) async {
    try {
      await _notificationDb.add({
        'title': 'Order Declined',
        'body': 'Your order for ${orderModel.menuName} has been declined',
        'notificationType': 'order',
        'orderId': orderModel.orderId,
        'senderId': orderModel.orderDetail.customerId,
        'receiverId': orderModel.catererId,
        'isRead': false,
        'createdAt': "${DateTime.now()}",
        'data': {
          'reason': reason,
          'orderInfo': orderModel.toJson()
        },
      });
      return 'Order cancelled';
    } on FirebaseException catch (err) {
      throw '$err';
    }
  }

}