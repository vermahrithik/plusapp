import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/core/themes/colors.dart';
import 'package:myapp/services/routes/route_names.dart';
import 'package:myapp/src/views/screens/error_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController addressLine01Controller = TextEditingController();
  TextEditingController addressLine02Controller = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  bool _obscureText = true;

  Future signUp(String pname,String mobile,String email,String password,String gender,String age,String address1,String address2,String city,String state1,String pincode) async {
    try {
      // final dio = Dio();
      //
      // // final response = await dio.get(
      // //   'https://api.themoviedb.org/3/trending/movie/day?language=en-US&api_key=7a3bd5d5f83da1324e1bfdf75f2a665c&page=$allMoviesPage',
      // // );
      // final response = await dio.post(
      //     'https://www.accessinfo.in/prsapi/user/login',data: {"mobile":int.parse(mobile),"password":int.parse(password)}
      // );
      // if(mobile.isNotEmpty && password.isNotEmpty){
      //
      // }
      //
      // debugPrint(response.statusCode.toString());
      // if(response.statusCode == 200){
      //   // if(allMoviesPage.value == 1){
      //   //   movies.value = response.data['results'].map<MovieModel>((movie)=> MovieModel.fromJson(movie)).toList();
      //   // }else{
      //   //   debugPrint("In page WITH CONDITION : ${allMoviesPage.value}");
      //   //   movies.addAll(response.data['results'].map<MovieModel>((movie)=> MovieModel.fromJson(movie)).toList());
      //   // }
      //   debugPrint(response.data);
      //   debugPrint(response.statusCode.toString());
      // }
      ///------------------------------
      var headers = {
        'Content-Type': 'application/json'
      };
      var data = json.encode({
        "pname": pname,
        "mobile": mobile,
        "email": email,
        "password":password,
        "gender": gender,
        "age": age,
        "address1": address1,
        "address2": address2,
        "city": city,
        "state1": state1,
        "pincode": int.parse(pincode)
      });

      var dio = Dio();
      dio.interceptors.add(LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        error: true,
      ));

      var response = await dio.request(
        'https://www.accessinfo.in/prsapi/user',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        nameController.text="";
        mobileController.text="";
        emailController.text="";
        passwordController.text="";
        genderController.text="";
        ageController.text="";
        addressLine01Controller.text="";
        addressLine02Controller.text="";
        cityController.text="";
        stateController.text="";
        pinCodeController.text="";
        print(json.encode(response.data.toString()));

        debugPrint(response.data["message"]);
        debugPrint(response.statusMessage);
        debugPrint(response.statusCode.toString());
        SharedPreferences.getInstance().then((value) => value.setBool('isLoggedIn', true),);

        context.goNamed(RouteNames.dashboard);
      }
      else {
        nameController.text="";
        mobileController.text="";
        emailController.text="";
        passwordController.text="";
        genderController.text="";
        ageController.text="";
        addressLine01Controller.text="";
        addressLine02Controller.text="";
        cityController.text="";
        stateController.text="";
        pinCodeController.text="";

        debugPrint(response.data);
        debugPrint(response.statusCode.toString());
        debugPrint(response.statusMessage);
      }
      debugPrint('response : ${response.statusCode}');
      debugPrint(response.statusMessage);
      /// ------------------------------------
      // final dio = Dio();
      // final response = await dio.get(
      //   'https://www.accessinfo.in/prsapi/user',
      // );
      // debugPrint(response.statusCode.toString());
      // if(response.statusCode == 200){
      //   debugPrint(response.data.toString());
      // }else{
      //   debugPrint("${response.statusCode}");
      //   debugPrint(response.data.toString());
      // }
    } catch (e) {
      debugPrint("Error in calling api :: $e");
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    emailController.dispose();
    passwordController.dispose();
    genderController.dispose();
    ageController.dispose();
    addressLine01Controller.dispose();
    addressLine02Controller.dispose();
    cityController.dispose();
    stateController.dispose();
    pinCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
        child: Scaffold(
          backgroundColor: AppColors.primaryColor01,
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  SizedBox(
                    height: 8.h,
                  ),

                  /// Logo Text
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
                    height: 15.sp,
                  ),

                  /// Sign Up Text :
                  Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontFamily: 'f2',
                      fontWeight: FontWeight.w100,
                      color: AppColors.primaryColor05,
                    ),
                  ),

                  SizedBox(
                    height: 8.sp,
                  ),

                  /// Name Label Text:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 20.w,
                      ),
                      Text(
                        'Name',
                        style: TextStyle(
                            color: AppColors.primaryColor05,
                            fontWeight: FontWeight.w600,
                            fontSize: 15.5.sp),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 8.sp,
                  ),

                  /// Name Input Field :
                  SizedBox(
                    height: 6.h,
                    width: 60.w,
                    child: TextFormField(
                      controller: nameController,
                      cursorColor: AppColors.primaryColor03,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 2.5.w, vertical: 0.h),
                        hintText: 'Name',
                        hintStyle: TextStyle(
                            color: AppColors.primaryColor03,
                            fontWeight: FontWeight.w300),
                        labelStyle: TextStyle(color: AppColors.primaryColor03),
                        enabled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.primaryColor02, width: 2.sp),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.primaryColor03, width: 2.sp),
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.primaryColor02, width: 2.sp),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 8.sp,
                  ),

                  /// Mobile Number Label Text:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 20.w,
                      ),
                      Text(
                        'Mobile Number',
                        style: TextStyle(
                            color: AppColors.primaryColor05,
                            fontWeight: FontWeight.w600,
                            fontSize: 15.5.sp),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 8.sp,
                  ),

                  /// Mobile Number Input Field :
                  SizedBox(
                    height: 6.h,
                    width: 60.w,
                    child: TextFormField(
                      controller: mobileController,
                      cursorColor: AppColors.primaryColor03,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 2.5.w, vertical: 0.h),
                        hintText: 'Mobile Number',
                        hintStyle: TextStyle(
                            color: AppColors.primaryColor03,
                            fontWeight: FontWeight.w300),
                        labelStyle: TextStyle(color: AppColors.primaryColor03),
                        enabled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.primaryColor02, width: 2.sp),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.primaryColor03, width: 2.sp),
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.primaryColor02, width: 2.sp),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 8.sp,
                  ),

                  /// Email Label Text:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 20.w,
                      ),
                      Text(
                        'Email Id (optional)',
                        style: TextStyle(
                            color: AppColors.primaryColor05,
                            fontWeight: FontWeight.w600,
                            fontSize: 15.5.sp),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 8.sp,
                  ),

                  /// Email Input Field :
                  SizedBox(
                    height: 6.h,
                    width: 60.w,
                    child: TextFormField(
                      controller: emailController,
                      cursorColor: AppColors.primaryColor03,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 2.5.w, vertical: 0.h),
                        hintText: 'Email ID',
                        hintStyle: TextStyle(
                            color: AppColors.primaryColor03,
                            fontWeight: FontWeight.w300),
                        labelStyle: TextStyle(color: AppColors.primaryColor03),
                        enabled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.primaryColor02, width: 2.sp),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.primaryColor03, width: 2.sp),
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.primaryColor02, width: 2.sp),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 8.sp,
                  ),

                  /// Password Label Text:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 20.w,
                      ),
                      Text(
                        'Password',
                        style: TextStyle(
                            color: AppColors.primaryColor05,
                            fontWeight: FontWeight.w600,
                            fontSize: 15.5.sp),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 8.sp,
                  ),

                  /// Password Input Field :
                  SizedBox(
                    height: 6.h,
                    width: 60.w,
                    child: TextFormField(
                      controller: passwordController,
                      cursorColor: AppColors.primaryColor03,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 2.5.w, vertical: 0.h),
                        hintText: 'Password',
                        hintStyle: TextStyle(
                            color: AppColors.primaryColor03,
                            fontWeight: FontWeight.w300),
                        labelStyle: TextStyle(color: AppColors.primaryColor03),
                        enabled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: AppColors.primaryColor02, width: 2.sp),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: AppColors.primaryColor03, width: 2.sp),
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: AppColors.primaryColor02, width: 2.sp),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 8.sp,
                  ),

                  /// Gender Label Text:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 20.w,
                      ),
                      Text(
                        'Gender',
                        style: TextStyle(
                            color: AppColors.primaryColor05,
                            fontWeight: FontWeight.w600,
                            fontSize: 15.5.sp),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 8.sp,
                  ),

                  /// Gender Input Field :
                  SizedBox(
                    height: 6.h,
                    width: 60.w,
                    child: TextFormField(
                      controller: genderController,
                      cursorColor: AppColors.primaryColor03,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 2.5.w, vertical: 0.h),
                        hintText: 'Gender',
                        hintStyle: TextStyle(
                            color: AppColors.primaryColor03,
                            fontWeight: FontWeight.w300),
                        labelStyle: TextStyle(color: AppColors.primaryColor03),
                        enabled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.primaryColor02, width: 2.sp),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.primaryColor03, width: 2.sp),
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.primaryColor02, width: 2.sp),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 8.sp,
                  ),

                  /// Age Label Text:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 20.w,
                      ),
                      Text(
                        'Age',
                        style: TextStyle(
                            color: AppColors.primaryColor05,
                            fontWeight: FontWeight.w600,
                            fontSize: 15.5.sp),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 8.sp,
                  ),

                  /// Age Input Field :
                  SizedBox(
                    height: 6.h,
                    width: 60.w,
                    child: TextFormField(
                      controller: ageController,
                      cursorColor: AppColors.primaryColor03,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 2.5.w, vertical: 0.h),
                        hintText: 'Age',
                        hintStyle: TextStyle(
                            color: AppColors.primaryColor03,
                            fontWeight: FontWeight.w300),
                        labelStyle: TextStyle(color: AppColors.primaryColor03),
                        enabled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.primaryColor02, width: 2.sp),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.primaryColor03, width: 2.sp),
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.primaryColor02, width: 2.sp),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 8.sp,
                  ),

                  /// Address Line 01 Label Text:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 20.w,
                      ),
                      Text(
                        'Address Line 01',
                        style: TextStyle(
                            color: AppColors.primaryColor05,
                            fontWeight: FontWeight.w600,
                            fontSize: 15.5.sp),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 8.sp,
                  ),

                  /// Address Line 01 Input Field :
                  SizedBox(
                    height: 6.h,
                    width: 60.w,
                    child: TextFormField(
                      controller: addressLine01Controller,
                      cursorColor: AppColors.primaryColor03,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 2.5.w, vertical: 0.h),
                        hintText: 'Address',
                        hintStyle: TextStyle(
                            color: AppColors.primaryColor03,
                            fontWeight: FontWeight.w300),
                        labelStyle: TextStyle(color: AppColors.primaryColor03),
                        enabled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.primaryColor02, width: 2.sp),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.primaryColor03, width: 2.sp),
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.primaryColor02, width: 2.sp),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 8.sp,
                  ),

                  /// Address Line 02 Label Text:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 20.w,
                      ),
                      Text(
                        'Address Line 02 (optional)',
                        style: TextStyle(
                            color: AppColors.primaryColor05,
                            fontWeight: FontWeight.w600,
                            fontSize: 15.5.sp),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 8.sp,
                  ),

                  /// Address Line 02 Input Field :
                  SizedBox(
                    height: 6.h,
                    width: 60.w,
                    child: TextFormField(
                      controller: addressLine02Controller,
                      cursorColor: AppColors.primaryColor03,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 2.5.w, vertical: 0.h),
                        hintText: 'Address',
                        hintStyle: TextStyle(
                            color: AppColors.primaryColor03,
                            fontWeight: FontWeight.w300),
                        labelStyle: TextStyle(color: AppColors.primaryColor03),
                        enabled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.primaryColor02, width: 2.sp),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.primaryColor03, width: 2.sp),
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.primaryColor02, width: 2.sp),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 8.sp,
                  ),

                  /// City Label Text:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 20.w,
                      ),
                      Text(
                        'City',
                        style: TextStyle(
                            color: AppColors.primaryColor05,
                            fontWeight: FontWeight.w600,
                            fontSize: 15.5.sp),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 8.sp,
                  ),

                  /// City Input Field :
                  SizedBox(
                    height: 6.h,
                    width: 60.w,
                    child: TextFormField(
                      controller: cityController,
                      cursorColor: AppColors.primaryColor03,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 2.5.w, vertical: 0.h),
                        hintText: 'City',
                        hintStyle: TextStyle(
                            color: AppColors.primaryColor03,
                            fontWeight: FontWeight.w300),
                        labelStyle: TextStyle(color: AppColors.primaryColor03),
                        enabled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.primaryColor02, width: 2.sp),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.primaryColor03, width: 2.sp),
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.primaryColor02, width: 2.sp),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 8.sp,
                  ),

                  /// State Label Text:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 20.w,
                      ),
                      Text(
                        'State',
                        style: TextStyle(
                            color: AppColors.primaryColor05,
                            fontWeight: FontWeight.w600,
                            fontSize: 15.5.sp),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 8.sp,
                  ),

                  /// State Input Field :
                  SizedBox(
                    height: 6.h,
                    width: 60.w,
                    child: TextFormField(
                      controller: stateController,
                      cursorColor: AppColors.primaryColor03,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 2.5.w, vertical: 0.h),
                        hintText: 'State',
                        hintStyle: TextStyle(
                            color: AppColors.primaryColor03,
                            fontWeight: FontWeight.w300),
                        labelStyle: TextStyle(color: AppColors.primaryColor03),
                        enabled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.primaryColor02, width: 2.sp),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.primaryColor03, width: 2.sp),
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.primaryColor02, width: 2.sp),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 8.sp,
                  ),

                  /// Pincode Label Text:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 20.w,
                      ),
                      Text(
                        'Pincode (optional)',
                        style: TextStyle(
                            color: AppColors.primaryColor05,
                            fontWeight: FontWeight.w600,
                            fontSize: 15.5.sp),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 8.sp,
                  ),

                  /// Pincode Input Field :
                  SizedBox(
                    height: 6.h,
                    width: 60.w,
                    child: TextFormField(
                      controller: pinCodeController,
                      keyboardType: TextInputType.number,
                      cursorColor: AppColors.primaryColor03,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 2.5.w, vertical: 0.h),
                        hintText: 'Pincode',
                        hintStyle: TextStyle(
                            color: AppColors.primaryColor03,
                            fontWeight: FontWeight.w300),
                        labelStyle: TextStyle(color: AppColors.primaryColor03),
                        errorStyle: TextStyle(color: AppColors.primaryColor11),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.primaryColor11),
                        ),
                        enabled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.primaryColor02, width: 2.sp),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.primaryColor03, width: 2.sp),
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.primaryColor02, width: 2.sp),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 2.h,
                  ),

                  /// SignUp Button :
                  SizedBox(
                    height: 6.h,
                    width: 60.w,
                    child: ElevatedButton(
                      onPressed: () {
                        signUp(nameController.text, mobileController.text, emailController.text, passwordController.text, genderController.text, ageController.text, addressLine01Controller.text, addressLine02Controller.text, cityController.text, stateController.text, pinCodeController.text);
                        context.goNamed(RouteNames.dashboard);
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
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor01,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 2.h,
                  ),

                  /// Divider :
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
                        style: TextStyle(
                            color: AppColors.primaryColor03, fontSize: 15.sp),
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

                  /// Navigate to Login Page :
                  GestureDetector(
                      onTap: () {
                        context.goNamed(RouteNames.login);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'have an account ?',
                            style: TextStyle(
                                color: AppColors.primaryColor03,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 1.w,
                          ),
                          Text(
                            'Login',
                            style: TextStyle(
                                color: AppColors.primaryColor00,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w800),
                          ),
                        ],
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
}
