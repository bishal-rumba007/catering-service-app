


import 'package:catering_service_app/src/features/auth/data/auth_datasource.dart';
import 'package:catering_service_app/src/features/auth/domain/auth_repo.dart';

class AuthRepoImpl implements AuthRepository{
  final AuthDataSource _authDataSource = AuthDataSource();

  @override
  Future<String> login({required String email, required String password}) async{
    final response = _authDataSource.userLogin(username: email, password: password);
    return response;
  }

  @override
  Future<String> register({required String name, required String email, required String phone, required String password}) {
    final response = _authDataSource.userSignup(fullName: name, email: email, phoneNumber: phone, password: password);
    return response;
  }

  @override
  Future<String> logOut() {
    final response = _authDataSource.userLogout();
    return response;
  }

}