


import 'package:catering_service_app/src/features/auth/data/auth_datasource.dart';
import 'package:catering_service_app/src/features/auth/domain/auth_repo.dart';

class AuthRepoImpl implements AuthRepository{

  @override
  Future<String> login({required String email, required String password}) async{
    final response = AuthDataSource().userLogin(username: email, password: password);
    return response;
  }

  @override
  Future<String> register({required String name, required String email, required String phone, required String password}) {
    final response = AuthDataSource().userSignup(fullName: name, email: email, phoneNumber: phone, password: password);
    return response;
  }

}