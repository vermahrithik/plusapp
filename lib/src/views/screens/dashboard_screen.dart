import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/core/themes/colors.dart';
import 'package:myapp/src/controllers/my_controller.dart';
import 'package:myapp/services/routes/route_names.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  final String mobile;
  const DashboardScreen({
    super.key,
    required this.mobile,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}


class _DashboardScreenState extends State<DashboardScreen> {
  final dataController = Get.find<MyController>();
  final GlobalKey<ScaffoldState> sKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataController.dataGetApiCall();
    dataController.dashboardDataApi(dataController.mobileNumber.value);
  }

  @override
  Widget build(BuildContext context) {
    final data = dataController.data;
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.primaryColor01,
      ),
      child: Obx(() {
        return Scaffold(
          backgroundColor: AppColors.primaryColor01,
          appBar: AppBar(
            iconTheme: IconThemeData(color: AppColors.primaryColor01),
            leading: BackButton(
              color: AppColors.primaryColor01,
              onPressed: () {
                context.pop();
              },
            ),
            centerTitle: true,
            title: Text('Dashboard',style: TextStyle(color: AppColors.primaryColor01),),
            backgroundColor: AppColors.primaryColor00,
            elevation: 4,
            shadowColor: AppColors.primaryColor14,
          ),
          endDrawer: Drawer(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0.sp)),
            key: sKey,
            width: 80.w,
            shadowColor: AppColors.primaryColor07.withOpacity(0.8),
            backgroundColor: AppColors.primaryColor05.withOpacity(0.8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: DrawerHeader(
                      child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('Menu',style: TextStyle(color: AppColors.primaryColor01,fontSize: 18.sp),),
                              SizedBox(
                                height: 7.h,
                                width: 15.w,
                                child: ElevatedButton(
                                    onPressed: () {
                                    setState(() {
                                     SharedPreferences.getInstance().then((value) async => await value.remove('isLoggedIn'),);
                                    });
                                    final snackBar = SnackBar(
                                      duration: Duration(milliseconds: 500),
                                      content: Center(
                                        child: Text(
                                          'Signout succesful!!',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: AppColors.primaryColor01, fontSize: 16, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      backgroundColor: Colors.green,
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
                                    context.goNamed(RouteNames.login);
                                    },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryColor11,
                                    fixedSize: Size(70.w, 30.0),
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  child: Text('SignOut',style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryColor01,
                                  ),),),
                              ),
                            ],
                          ))
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          debugPrint('enddrawer data : Index $index');
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.0.w,vertical: 2.h,),
                          child: Container(
                            height: 40.h,
                            decoration: BoxDecoration(
                                color: AppColors.primaryColor01,
                                borderRadius: BorderRadius.all(Radius.circular(20.sp))),
                            child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'ID : ${data[index]["_id"].toString()}',
                                      style: TextStyle(
                                          color: AppColors.primaryColor00,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(height: 1.h),
                                    Text(
                                      'Name : ${data[index]["pname"].toString()}',
                                      style: TextStyle(
                                          color: AppColors.primaryColor00,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(height: 1.h),
                                    Text(
                                      'Mobile : ${data[index]["mobile"].toString()}',
                                      style: TextStyle(
                                          color: AppColors.primaryColor00,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(height: 1.h),
                                    Text(
                                      'Email Id : ${data[index]["email"].toString()}',
                                      style: TextStyle(
                                          color: AppColors.primaryColor00,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(height: 1.h),
                                    Text(
                                      'Gender : ${data[index]["gender"].toString()}',
                                      style: TextStyle(
                                          color: AppColors.primaryColor00,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(height: 1.h),
                                    Text(
                                      'Age : ${data[index]["age"].toString()}',
                                      style: TextStyle(
                                          color: AppColors.primaryColor00,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(height: 1.h),
                                    Text(
                                      'Address Line 01 : ${data[index]["address1"].toString()}',
                                      style: TextStyle(
                                          color: AppColors.primaryColor00,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(height: 1.h),
                                    Text(
                                      'Address Line 02 : ${data[index]["address2"].toString()}',
                                      style: TextStyle(
                                          color: AppColors.primaryColor00,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(height: 1.h),
                                    Text(
                                      'City : ${data[index]["city"].toString()}',
                                      style: TextStyle(
                                          color: AppColors.primaryColor00,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(height: 1.h),
                                    Text(
                                      'State : ${data[index]["state1"].toString()}',
                                      style: TextStyle(
                                          color: AppColors.primaryColor00,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(height: 1.h),
                                    Text(
                                      '${data[index]["pincode"].toString()}',
                                      style: TextStyle(
                                          color: AppColors.primaryColor00,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    // SizedBox(height: 1.h),
                                  ],
                                )),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          body: Center(
            child: dataController.dashboardData.isNotEmpty ? GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 1.0),
              itemCount: dataController.dashboardData.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(10.sp),
                  child: Card(
                    elevation: 4,
                    color: AppColors.primaryColor01,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.sp)),
                    shadowColor: AppColors.primaryColor14,
                    child: Center(
                      child:Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('${dataController.dashboardData[index]['ptcode']}',style: TextStyle(color: AppColors.primaryColor05,fontFamily: 'f2',fontSize: 14.sp,fontWeight: FontWeight.w400),),
                          Text('${dataController.dashboardData[index]['pname']}',style: TextStyle(color: AppColors.primaryColor05,fontFamily: 'f2',fontSize: 14.sp,fontWeight: FontWeight.w400),),
                          Text('${dataController.dashboardData[index]['age']}',style: TextStyle(color: AppColors.primaryColor05,fontFamily: 'f2',fontSize: 14.sp,fontWeight: FontWeight.w400),),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
                :
            GestureDetector(
              onTap: () {
                final snackBar = SnackBar(
                  content: Text(
                    'SignOut and Login Again',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColors.primaryColor01, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: Colors.yellow.shade700,
                  behavior: SnackBarBehavior.floating,
                  duration: Duration(milliseconds: 400),
                  elevation: 8.0,
                  margin: EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  action: SnackBarAction(
                    label: '',
                    textColor: AppColors.transparent,
                    onPressed: () {
                      // Add your undo action here
                    },
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: Container(
                height: 6.h,
                width: 28.w,
                decoration: BoxDecoration(
                    color: AppColors.primaryColor07.withOpacity(0.6),
                    borderRadius: BorderRadius.all(Radius.circular(12.sp)),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryColor01.withOpacity(0.8),
                        blurRadius: 10.sp,
                        offset: Offset(-1, -1),
                        spreadRadius: 6.sp,
                      ),
                      BoxShadow(
                        color: AppColors.primaryColor07.withOpacity(0.8),
                        blurRadius: 10.sp,
                        offset: Offset(2, 2),
                        spreadRadius: 6.sp,
                      ),
                    ]
                ),
                child: Center(
                  child: Text(
                    'SignOut and Login Again',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.primaryColor08,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },),
    );
  }
}

Widget buildButton(context,String optionText){
  return GestureDetector(
    onTap: () {
      // context.pushNamed(RouteNames.scanQR);
      final snackBar = SnackBar(
        content: Text(
          optionText,
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.primaryColor01, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        duration: Duration(milliseconds: 300),
        elevation: 8.0,
        margin: EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        action: SnackBarAction(
          label: '',
          textColor: AppColors.transparent,
          onPressed: () {
            // Add your undo action here
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    },
    child: Padding(
      padding: EdgeInsets.all(12.0.sp),
      child: Container(
        height: 6.h,
        width: 28.w,
        decoration: BoxDecoration(
            color: AppColors.primaryColor07.withOpacity(0.6),
            borderRadius: BorderRadius.all(Radius.circular(12.sp)),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryColor01.withOpacity(0.8),
                blurRadius: 10.sp,
                offset: Offset(-1, -1),
                spreadRadius: 6.sp,
              ),
              BoxShadow(
                color: AppColors.primaryColor07.withOpacity(0.8),
                blurRadius: 10.sp,
                offset: Offset(2, 2),
                spreadRadius: 6.sp,
              ),
            ]
        ),
        child: Center(
          child: Text(
            optionText,
            style: TextStyle(
              color: AppColors.primaryColor08,
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    ),
  );
}