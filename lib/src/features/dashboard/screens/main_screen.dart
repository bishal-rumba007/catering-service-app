
import 'package:catering_service_app/src/features/dashboard/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return const HomeScreen();
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Home Page'),
    //     centerTitle: true,
    //     actions: [
    //       IconButton(
    //         onPressed: () async{
    //           await authData.logOut();
    //         },
    //         icon: const Icon(Icons.logout),
    //       )
    //     ],
    //   ),
    // );
  }
}
