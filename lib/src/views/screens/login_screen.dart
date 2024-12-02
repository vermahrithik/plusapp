import 'dart:convert';

import 'package:myapp/core/themes/colors.dart';
import 'package:myapp/services/routes/route_names.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/src/controllers/my_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final dataController = Get.find<MyController>();

  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _obscureText = true;

  @override
  void dispose() {
    mobileController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
        child: Scaffold(
          backgroundColor: AppColors.primaryColor01,
          appBar: AppBar(
            backgroundColor: AppColors.transparent,
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Plus App',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: 'f1',
                      fontSize: 32.sp,
                      color: AppColors.primaryColor00,
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    'Login',
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontFamily: 'f2',
                        fontWeight: FontWeight.w100,
                        color: AppColors.primaryColor05,
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  SizedBox(
                    height: 6.h,
                    width: 60.w,
                    child: TextFormField(
                      controller: mobileController,
                      cursorColor: AppColors.primaryColor03,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal:2.5.w,vertical: 0.h),
                        hintText: 'Mobile Number',
                        hintStyle: TextStyle(
                            color: AppColors.primaryColor03,
                            fontWeight: FontWeight.w300),
                        labelStyle:
                        TextStyle(color: AppColors.primaryColor03),
                        enabled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: AppColors.primaryColor02, width: 2.sp),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.primaryColor03, width: 2.sp),
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: AppColors.primaryColor02, width: 2.sp),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.sp,
                  ),
                  SizedBox(
                    height: 6.h,
                    width: 60.w,
                    child: TextFormField(
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      cursorColor: AppColors.primaryColor03,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal:2.5.w,vertical: 0.h),
                        hintText: 'Password',
                        hintStyle: TextStyle(
                            color: AppColors.primaryColor03,
                            fontWeight: FontWeight.w300),
                        labelStyle:
                        TextStyle(color: AppColors.primaryColor03),
                        errorStyle: TextStyle(color: AppColors.primaryColor11),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.primaryColor11),
                        ),
                        enabled: true,
                        // prefixIcon: Icon(Icons.text_fields),
                        suffixIcon: togglePassword(),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: AppColors.primaryColor02, width: 2.sp),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.primaryColor03, width: 2.sp),
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: AppColors.primaryColor02, width: 2.sp),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(
                            color: AppColors.primaryColor03,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp),
                      ),
                      SizedBox(
                        width: 20.w,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  SizedBox(
                    height: 6.h,
                    width: 60.w,
                    child: ElevatedButton(
                      onPressed: () {
                        dataController.signIn(mobileController.text,passwordController.text,context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor05,
                        fixedSize: Size(deviceWidth * 0.75, 30.0),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor01,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 25.w,
                        height: 0.2.h,
                        color: AppColors.primaryColor02,
                      ),
                      SizedBox(
                        width: 2.w,
                        height: 0,
                      ),
                      Text(
                        'OR',
                        style: TextStyle(color: AppColors.primaryColor03, fontSize: 15.sp),
                      ),
                      SizedBox(
                        width: 2.w,
                        height: 0,
                      ),
                      Container(
                        width: 25.w,
                        height: 0.2.h,
                        color: AppColors.primaryColor02,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  GestureDetector(
                      onTap: () {
                        context.goNamed(RouteNames.signUp);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'New User ?',
                            style: TextStyle(
                                color: AppColors.primaryColor03,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 1.w,
                          ),
                          Text(
                            'Sign Up',
                            style: TextStyle(
                                color: AppColors.primaryColor00,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w800),
                          ),
                        ],
                      )),

                  SizedBox(
                    height: 5.h,
                  ),

                  GestureDetector(
                      onTap: () {
                        context.pushNamed(RouteNames.scanQR);
                      },
                      child: Text(
                        'Scan QR Code',
                        style: TextStyle(
                            color: AppColors.primaryColor00,
                            fontSize: 16.sp,
                            fontFamily: 'f2',
                            fontWeight: FontWeight.w800),
                      )),

                  SizedBox(
                    height: 10.h,
                  ),
                ],
              ),
            ),
          ),
        ),
        onWillPop: () async {
          SystemNavigator.pop();
          return true;
        });
  }

  Widget togglePassword() {
    return IconButton(
      onPressed: () {
        setState(() {
          _obscureText = !_obscureText;
        });
      },
      icon: _obscureText
          ? Icon(Icons.visibility_outlined)
          : Icon(Icons.visibility_off_outlined),
      color: AppColors.primaryColor02,
    );
  }
}