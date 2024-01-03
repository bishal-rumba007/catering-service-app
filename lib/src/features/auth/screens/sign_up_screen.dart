import 'package:catering_service_app/src/common/common_export.dart';
import 'package:catering_service_app/src/features/auth/screens/auth_provider.dart';
import 'package:catering_service_app/src/features/auth/screens/login_screen.dart';
import 'package:catering_service_app/src/features/dashboard/screens/home_screen.dart';
import 'package:catering_service_app/src/themes/export_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Create an Account',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(color: Colors.black),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  BuildTextFormField(
                    controller: _nameController,
                    labelText: 'Full Name',
                    textInputType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BuildTextFormField(
                    controller: _emailController,
                    labelText: 'Email',
                    textInputType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BuildTextFormField(
                    controller: _phoneController,
                    labelText: 'Phone Number',
                    textInputType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BuildPasswordTextFormField(
                    labelText: 'Password',
                    textInputAction: TextInputAction.done,
                    controller: _passwordController,
                  ),
                  const SizedBox(height: 50,),
                  Consumer(
                    builder: (context, ref, child) {
                      final authData = ref.watch(authProvider);
                      return BuildButton(
                        onPressed: () async{
                          final navigator = Navigator.of(context);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const AlertDialog(
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CircularProgressIndicator(),
                                    SizedBox(height: 16),
                                    Text("Creating account..."),
                                  ],
                                ),
                              );
                            },
                          );
                          final response = await authData.register(
                            name: _nameController.text.trim(),
                            email: _emailController.text.trim(),
                            phone: _phoneController.text.trim(),
                            password: _passwordController.text.trim(),
                          );
                          navigator.pop();
                          if(response != "Registration Successful"){
                            print('something went wrong');
                          }else{
                            navigator.push(MaterialPageRoute(builder: (_) => const HomeScreen(),));
                          }
                        },
                        buttonWidget: const Text('Create account'),
                      );
                    },
                  ),
                  const SizedBox(height: 60,),
                  Text(
                    'Already have an account?',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColor.darkColor.withOpacity(0.9),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen(),));
                    },
                    child: const Text('Login instead'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}