// import 'package:catering_service_app/src/features/auth/data/auth_datasource.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter_test/flutter_test.dart';
//
// void main() {
//   Firebase.initializeApp();
//   late AuthDataSource authDataSource;
//   late FirebaseAuth firebaseAuth;
//
//   setUp(() {
//     // Initialize FirebaseAuth
//     firebaseAuth = FirebaseAuth.instance;
//     authDataSource = AuthDataSource();
//   });
//
//   test('userLogin should return "Login Successful" on successful login', () async {
//     // Test account credentials for successful login
//     const testEmail = 'test@email.com';
//     const testPassword = 'testPassword';
//
//     try {
//       // Sign up the test account
//       await firebaseAuth.createUserWithEmailAndPassword(
//         email: testEmail,
//         password: testPassword,
//       );
//
//       // Act
//       final result = await authDataSource.userLogin(
//         username: testEmail,
//         password: testPassword,
//       );
//
//       // Assert
//       expect(result, 'Login Successful');
//     } catch (error) {
//       // Handle exceptions, if any
//       fail('Test setup failed: $error');
//     }
//   });
//
//   test('userLogin should return an error message on unsuccessful login', () async {
//     // Test account credentials for unsuccessful login
//     const testEmail = 'nonexistent@email.com';
//     const testPassword = 'wrongPassword';
//
//     // Act
//     final result = await authDataSource.userLogin(
//       username: testEmail,
//       password: testPassword,
//     );
//
//     // Assert
//     expect(result, isNotEmpty); // Assuming an error message is returned
//   });
// }

// import 'package:catering_service_app/src/features/auth/data/auth_datasource.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
//
//
// class MockFirebaseAuth extends Mock implements FirebaseAuth {}
// class MockUserCredential extends Mock implements UserCredential {}
//
//
// void main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//
//
//   late MockFirebaseAuth mockFirebaseAuth;
//   late AuthDataSource authDataSource;
//
//   late MockUserCredential mockUserCredential;
//
//   setUp(() {
//     mockFirebaseAuth = MockFirebaseAuth();
//     authDataSource = AuthDataSource();
//     mockUserCredential = MockUserCredential();
//   });
//
//   group('signIn', () {
//
//     test('calls Firebase API and returns success', () async {
//
//       // Arrange
//       when(mockFirebaseAuth.signInWithEmailAndPassword(
//           email: 'test@email.com',
//           password: 'password'
//       )).thenAnswer((_) async => mockUserCredential);
//
//       // Act
//       final result = await authDataSource.userLogin(
//           username: 'test@email.com',
//           password: 'password'
//       );
//
//       // Assert
//       verify(mockFirebaseAuth.signInWithEmailAndPassword(
//           email: 'test@email.com',
//           password: 'password'
//       ));
//
//       expect(result, 'Login Successful');
//     });
//
//     test('returns error message on exception', () async {
//       // Arrange
//       when(mockFirebaseAuth.signInWithEmailAndPassword(
//           email: 'test@email.com',
//           password: 'password'
//       )).thenThrow(FirebaseAuthException(code: 'user-not-found'));
//
//       // Act
//       final result = await authDataSource.userLogin(
//           username: 'test@email.com',
//           password: 'password'
//       );
//
//       // Assert
//       verify(mockFirebaseAuth.signInWithEmailAndPassword(
//           email: 'test@email.com',
//           password: 'password'
//       ));
//
//       expect(result, 'user-not-found');
//     });
//
//   });
//
// }