
import 'package:catering_service_app/src/features/search/domain/search_menu_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchDataSource{
  final orderDb = FirebaseFirestore.instance.collection('orders');


  Future<List<SearchMenuModel>> searchMenu(String query) async{
    try{
      final result = await orderDb.where('catererId', isEqualTo: query).get();
      final searchResult = result.docs.map((e) => SearchMenuModel.fromJson(e.data())).toList();
      return searchResult;
    }on FirebaseException catch(e){
      throw e.message.toString();
    }
  }

}