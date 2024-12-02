import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:myapp/core/themes/colors.dart';
import 'package:myapp/services/routes/route_names.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

class ScannedQRCodeData extends StatefulWidget {
  final Uri uri;
  const ScannedQRCodeData({
    super.key,
    required this.uri,
  });

  @override
  State<ScannedQRCodeData> createState() => _ScannedQRCodeDataState();
}

class _ScannedQRCodeDataState extends State<ScannedQRCodeData> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/restro.jpg'),
                fit: BoxFit.cover,
                alignment: Alignment.center),
          ),
        ),
        GlassmorphicContainer(
          height: double.infinity,
          width: double.infinity,
          linearGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primaryColor07.withOpacity(0.3),
                AppColors.primaryColor07.withOpacity(0.1),
              ],
              stops: [
                0.3,
                1,
              ]),
          border: 0,
          blur: 4,
          borderGradient: LinearGradient(
              colors: [AppColors.transparent, AppColors.primaryColor02]),
          borderRadius: 0,
          child: Scaffold(
            backgroundColor: AppColors.transparent,
            appBar: AppBar(
              leading: BackButton(
                color: AppColors.primaryColor02,
                onPressed: () {
                  context.pop();
                },
              ),
              centerTitle: true,
              title: Text('QR Data',style: TextStyle(color: AppColors.primaryColor02),),
              backgroundColor: AppColors.transparent,
            ),
            body: Center(
              child: Link(
                  uri: widget.uri,
                  builder: (context, followLink) => GestureDetector(
                    onTap: () {
                      launchUrl(widget.uri,mode: LaunchMode.externalApplication);
                    },
                    child: Container(
                      height: 6.h,
                      width: 28.w,
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor07.withOpacity(0.6),
                          borderRadius: BorderRadius.all(Radius.circular(12.sp)),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primaryColor02.withOpacity(0.8),
                              blurRadius: 10.sp,
                              offset: Offset(-2, -2),
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
                          widget.uri.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.primaryColor08,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}