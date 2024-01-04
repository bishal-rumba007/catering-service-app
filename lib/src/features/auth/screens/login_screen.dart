import 'package:catering_service_app/src/common/common_export.dart';
import 'package:catering_service_app/src/features/auth/screens/auth_provider.dart';
import 'package:catering_service_app/src/features/auth/screens/sign_up_screen.dart';
import 'package:catering_service_app/src/features/auth/screens/widgets/build_dialogs.dart';
import 'package:catering_service_app/src/features/dashboard/screens/main_screen.dart';
import 'package:catering_service_app/src/themes/export_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 200.h,
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
                  SizedBox(
                    height: 30.h,
                  ),
                  BuildTextFormField(
                    controller: _usernameController,
                    labelText: 'Username',
                    textInputType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  BuildPasswordTextFormField(
                    labelText: 'Password',
                    textInputAction: TextInputAction.done,
                    controller: _passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 50.h),
                  Consumer(
                    builder: (context, ref, child) {
                      final authData = ref.watch(authProvider);
                     return BuildButton(
                       onPressed: () async{
                         if(_formKey.currentState!.validate()){
                           final navigator = Navigator.of(context);
                           buildLoadingDialog(context, "Logging in..");
                           final response = await authData.login(
                             email: _usernameController.text.trim(),
                             password: _passwordController.text.trim(),
                           );
                           navigator.pop();
                           if(response != 'Login Successful'){
                             if(!context.mounted) return;
                             buildErrorDialog(context, response);
                           }else{
                             navigator.push(MaterialPageRoute(builder: (_) => const MainScreen(),));
                           }
                         }
                       },
                       buttonWidget: const Text('Login'),
                     );
                    }
                  ),
                  SizedBox(height: 60.h,),
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
      ),
    );
  }
}
