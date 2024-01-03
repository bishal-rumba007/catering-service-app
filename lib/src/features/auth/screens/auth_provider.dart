


import 'package:catering_service_app/src/features/auth/data/auth_repo_impl.dart';
import 'package:catering_service_app/src/features/auth/domain/auth_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = Provider<AuthRepository>((ref) {
  return AuthRepoImpl();
});