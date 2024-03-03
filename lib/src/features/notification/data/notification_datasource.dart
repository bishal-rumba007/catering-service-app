import 'package:catering_service_app/src/api/api_keys.dart';
import 'package:catering_service_app/src/api/endpoints.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NotificationDataSource{
  final _notificationDb = FirebaseFirestore.instance.collection('notifications');

  Stream<List<NotificationModel>> getNotifications(){
    final uid = FirebaseAuth.instance.currentUser!.uid;
    try{
      final data =  _notificationDb.where('receiverId', isEqualTo: uid).snapshots();
      final response = data.asyncMap((event) async {
        final data = Future.wait(event.docs.map((e) async {
          final json = e.data();
          return NotificationModel.fromJson({
            ...json,
            'notificationId': e.id,
          });
        }).toList());
        return data;
      });
      return response;
    }on FirebaseException catch(e){
      throw Exception(e.message);
    }
  }

  Future<String> updateNotificationReadStatus(String notificationId) async{
    try{
      await _notificationDb.doc(notificationId).update({
        'isRead': true
      });
      return 'Notification read status updated';
    }on FirebaseException catch(e){
      throw Exception(e.message);
    }
  }

  Future<void> sendNotification({required String token, required String title, required String message, Map<String, dynamic>? notificationData}) async {
    final dio = Dio(
        BaseOptions(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'key=$serverKey',
          },
          baseUrl: ApiEndPoints.baseNotificationUrl,
        )
    );
    try{
      await dio.post(
          ApiEndPoints.baseNotificationUrl,
          data: {
            "to": token,
            "priority": "High",
            "default_notification_channel_id": "high_importance_channel",
            "notification":{
              "body": message,
              "title": title,
            },
            "data": notificationData,
          }
      );
    }on FirebaseException catch (err){
      throw Exception(err.message);
    }
  }

}



class NotificationModel{
  final String notificationId;
  final String title;
  final String body;
  final String createdAt;
  Map<String, dynamic>? notificationData;
  final String notificationType;
  final String senderId;
  final String receiverId;
  final bool isRead;

  NotificationModel({
    required this.notificationId,
    required this.title,
    required this.body,
    required this.createdAt,
    this.notificationData,
    required this.notificationType,
    required this.senderId,
    required this.receiverId,
    required this.isRead
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json){
    return NotificationModel(
        notificationId: json['notificationId'] as String,
        title: json['title'] as String,
        body: json['body'] as String,
        createdAt: json['createdAt'] as String,
        notificationData: json['notificationData'] as Map<String, dynamic>? ?? {},
        notificationType: json['notificationType'] as String,
        senderId: json['senderId'] as String,
        receiverId: json['receiverId'] as String,
        isRead: json['isRead'] as bool
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'title': title,
      'body': body,
      'createdAt': createdAt,
      'notificationData': notificationData,
      'notificationType': notificationType,
      'senderId': senderId,
      'receiverId': receiverId,
      'isRead': isRead
    };
  }
}