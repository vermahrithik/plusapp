import 'package:flutter/material.dart';
import 'package:myapp/core/themes/colors.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error Page',style: TextStyle(color: AppColors.primaryColor01),),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor15,
      ),
      body: const Center(
        child: Text('Error Page'),
      ),
    );
  }
}