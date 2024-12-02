import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:myapp/core/themes/colors.dart';
import 'package:myapp/core/themes/colors.dart';
import 'package:myapp/core/themes/colors.dart';
import 'package:myapp/services/routes/route_names.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';

enum Status {success, loading, failed, networkError}

class MyController extends GetxController {
  final data = [].obs;
  final dashboardData = [].obs;
  final mobileNumber = ''.obs;

  // String get statusCode => _statusCode;

  // set statusCode(String StatusCode) {
  //   _statusCode = StatusCode;
  //   update();
  // }

  Future<void> dataGetApiCall() async {
    try {
      final dio = Dio();
      final response = await dio.get(
        'https://www.accessinfo.in/prsapi/user',
      );
      // debugPrint("${response.data}");
      // debugPrint(response.statusCode.toString());

      if(response.statusCode == 200 || response.statusCode == 202){
        data.value = response.data;
        debugPrint("response.statusCode : ${response.statusCode.toString()}");
        debugPrint("data : $data");
      }else{
        data.value = response.data;
        debugPrint("response.statusCode : ${response.statusCode.toString()}");
        debugPrint("data :${data}");
      }
    } catch (e) {
      debugPrint("Error in calling API :: $e");
    }
  }

  Future signIn(String mobile,String password,BuildContext context) async {
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
        "mobile": mobile,
        "password": password
      });

      mobileNumber.value = mobile;

      var dio = Dio();
      dio.interceptors.add(LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        error: true,
      ));
      var response = await dio.request(
        'https://www.accessinfo.in/prsapi/user/login',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        debugPrint(response.data["message"]);
        debugPrint(response.statusMessage);
        debugPrint(response.statusCode.toString());
        SharedPreferences.getInstance().then((value) => value.setBool('isLoggedIn', true),);
        final snackBar = SnackBar(
          duration: Duration(milliseconds: 500),
          // padding: EdgeInsets.symmetric(vertical: 0.0.w,horizontal: 0.0.w),
          content: Center(
            child: Text(
              '${response.data["message"]}',
              textAlign: TextAlign.center,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: AppColors.primaryColor01,overflow: TextOverflow.ellipsis, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          backgroundColor: AppColors.primaryColor12,
          behavior: SnackBarBehavior.floating,
          elevation: 8.0,
          margin: EdgeInsets.all(42.sp),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28.sp),
          ),
          action: SnackBarAction(
            label: 'ok',
            textColor: AppColors.transparent,
            onPressed: () {
              // Add your undo action here
            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return context.goNamed(RouteNames.dashboard,queryParameters: {'mobile':mobileNumber.value});
      }else if(response.statusCode == 404 || response.statusCode == 401){
        debugPrint(response.data);
        debugPrint(response.statusCode.toString());
        debugPrint(response.statusMessage);
        final snackBar = SnackBar(
          duration: Duration(milliseconds: 1500),
          // padding: EdgeInsets.symmetric(vertical: 0.0.w,horizontal: 0.0.w),
          content: Center(
            child: Text(
              '${response.data["message"]}',
              textAlign: TextAlign.center,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: AppColors.primaryColor01,overflow: TextOverflow.ellipsis, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          backgroundColor: AppColors.primaryColor11,
          behavior: SnackBarBehavior.floating,
          elevation: 8.0,
          margin: EdgeInsets.all(42.sp),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28.sp),
          ),
          action: SnackBarAction(
            label: 'ok',
            textColor: AppColors.transparent,
            onPressed: () {},
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      debugPrint('response : ${response.statusCode}');
      debugPrint(response.statusMessage);
    } catch (e) {
      debugPrint("Error in calling api :: $e");
      final snackBar = SnackBar(
        duration: Duration(milliseconds: 1500),
        // padding: EdgeInsets.symmetric(vertical: 0.0.w,horizontal: 0.0.w),
        content: Center(
          child: Text(
            '${e.toString()}',
            textAlign: TextAlign.center,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: AppColors.primaryColor01,overflow: TextOverflow.ellipsis, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: AppColors.primaryColor11,
        behavior: SnackBarBehavior.floating,
        elevation: 8.0,
        margin: EdgeInsets.all(42.sp),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28.sp),
        ),
        action: SnackBarAction(
          label: 'ok',
          textColor: AppColors.transparent,
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> dashboardDataApi(String mobile) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var queryParameters = {
        'mobile': mobile,
      };

      var dio = Dio();

      dio.interceptors.add(
        LogInterceptor(
          request: true,
          requestBody: true,
          responseBody: true,
          error: true,
        ),
      );

      var response = await dio.request(
        'https://www.accessinfo.in/prsapi/transact/gettransbymob',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
        queryParameters: queryParameters,
      );

      // Handle the response
      if (response.statusCode == 200) {
        debugPrint('Response: ${response.data}');
        dashboardData.value = response.data;
      } else {
        debugPrint('Error Response: ${response.statusCode} \n ${response.statusMessage}');
        dashboardData.value = response.data;
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
  }



  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // dataGetApiCall();
  }

}
