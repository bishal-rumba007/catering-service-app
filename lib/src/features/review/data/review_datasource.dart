



import 'package:catering_service_app/src/features/review/domain/review_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewDataSource{


  final _reviewDb = FirebaseFirestore.instance.collection('reviews');

  Stream<List<ReviewModel>> getReviewsStream(String menuId) {
    try {
      final data = _reviewDb.where('menuId', isEqualTo: menuId).snapshots();
      final response = data.asyncMap((event) async {
        final data = Future.wait(event.docs.map((e) async {
          final json = e.data();
          return ReviewModel.fromJson({
            ...json,
            'reviewId': e.id,
          });
        }).toList());
        return data;
      });
      return response;
    } on FirebaseException catch (error) {
      throw '$error';
    }
  }

}