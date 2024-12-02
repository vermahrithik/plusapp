import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/src/controllers/my_controller.dart';
import 'package:myapp/services/routes/myapp_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  GoRouter.optionURLReflectsImperativeAPIs = true;
  setPathUrlStrategy();
  debugPrint('setpathurlstrategy : ok');
  WidgetsFlutterBinding.ensureInitialized();
  debugPrint('WidgetsFlutterBinding : ok');
  Get.put(MyController());
  debugPrint('MyController : ok');
  GoRouter router = myappRouter.router;
  debugPrint('GoRouter router= myappRouter.router; : ok');
  runApp(myapp(routerr: router));
  debugPrint('GoRouter router= myappRouter.router; : ok');
}

class myapp extends StatelessWidget {
  const myapp({super.key, required this.routerr});
  final GoRouter routerr;
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screentype) {
        return GetMaterialApp.router(
          debugShowCheckedModeBanner: false,
          routeInformationParser: routerr.routeInformationParser,
          routerDelegate: routerr.routerDelegate,
          routeInformationProvider: routerr.routeInformationProvider,
        );
      },
    );
  }
}
