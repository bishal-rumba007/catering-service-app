




import 'package:flutter/material.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
        title: const Text('Reviews'),
      ),
      body: const Center(
        child: Text('Reviews'),
      ),
    );
  }
}
