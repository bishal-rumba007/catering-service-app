import 'package:catering_service_app/src/common/common_export.dart';
import 'package:catering_service_app/src/features/auth/screens/sign_up_screen.dart';
import 'package:catering_service_app/src/themes/export_themes.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 200,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Login',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(color: Colors.black),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                BuildTextFormField(
                  controller: _usernameController,
                  labelText: 'Username',
                  textInputType: TextInputType.emailAddress,
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
                const SizedBox(height: 50),
                BuildButton(
                  onPressed: (){

                  },
                  buttonWidget: const Text('Login'),
                ),
                const SizedBox(height: 60,),
                Text(
                  'Don\'t have an account?',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColor.darkColor.withOpacity(0.9),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const SignUpScreen(),));
                  },
                  child: const Text('Create an account'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
