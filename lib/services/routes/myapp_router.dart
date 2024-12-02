import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/main.dart';
import 'package:myapp/services/routes/route_names.dart';
import 'package:myapp/services/routes/route_paths.dart';
import 'package:myapp/src/views/screens/dashboard_screen.dart';
import 'package:myapp/src/views/screens/error_screen.dart';
import 'package:myapp/src/views/screens/guest_dashboard.dart';
import 'package:myapp/src/views/screens/login_screen.dart';
import 'package:myapp/src/views/screens/scan_qr.dart';
import 'package:myapp/src/views/screens/scannedCodeData.dart';
import 'package:myapp/src/views/screens/sign_up_screen.dart';
import 'package:myapp/src/views/screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class myappRouter{

  static final GoRouter router = GoRouter(
    initialLocation: '/',
    // navigatorKey: navigatorKey,
    redirect: (context, state) async {
      debugPrint("Path  :${state.uri}");
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      if(sharedPreferences.getBool('isLoggedIn')==true){
        if(state.uri.toString().contains('/login') || state.uri.toString().contains('/signup')){
          return RoutePaths.dashboard;
        }
      }else {
        if(state.uri.toString().contains(RoutePaths.login)){
          return RoutePaths.login;
        }else if(state.uri.toString().contains(RoutePaths.signUp)){
          return RoutePaths.signUp;
        }else if(state.uri.toString().contains(RoutePaths.dashboardGuest)){
          return RoutePaths.dashboardGuest;
        }else{
          return null;
        }
      }
      return null;
    },
    debugLogDiagnostics: true,
    // errorPageBuilder: (context,state){
    //   return const MaterialPage(child: ErrorPage());
    // },
    errorBuilder: (context, state) {
      return const ErrorPage();
    },
    routes: [
      // Splash Screen Route :
      GoRoute(
        name: RouteNames.splash,
        path: RoutePaths.splash,
        pageBuilder: (context,state){
          debugPrint('config page : SplashScreen');
          return const MaterialPage(child: SplashScreen()); },
      ),
      // Login Page Route :
      GoRoute(
        name: RouteNames.login,
        path: RoutePaths.login,
        pageBuilder: (context,state){
          debugPrint('config page : LoginScreen');
          return const MaterialPage(child: LoginPage());
        },
      ),
      GoRoute(
        name: RouteNames.signUp,
        path: RoutePaths.signUp,
        pageBuilder: (context,state){
          debugPrint('config page : SignUpScreen');
          return const MaterialPage(child: SignUpPage());
        },
      ),
      GoRoute(
        name: RouteNames.dashboard,
        path: RoutePaths.dashboard,
        pageBuilder: (context,state){
          debugPrint('config page : dashboardScreen');
          // Query parameter
          final String mobile = state.uri.queryParameters['mobile']??'not-found';
          return MaterialPage(child: DashboardScreen(mobile: mobile));
        },
      ),
      GoRoute(
        name: RouteNames.dashboardGuest,
        path: RoutePaths.dashboardGuest,
        pageBuilder: (context,state){
          debugPrint('config page : dashboardGuestScreen');
          return const MaterialPage(child: GuestDashboardScreen());
        },
      ),
      GoRoute(
        name: RouteNames.error,
        path: RoutePaths.error,
        pageBuilder: (context,state){
          debugPrint('config page : errorScreen');
          return const MaterialPage(child: ErrorPage());
        },
      ),
      GoRoute(
        name: RouteNames.scanQR,
        path: RoutePaths.scanQR,
        pageBuilder: (context,state){
          debugPrint('config page : scanQRScreen');
          return const MaterialPage(child: ScanQR());
        },
      ),
      GoRoute(
        name: RouteNames.scannedCodeData,
        path: RoutePaths.scannedCodeData,
        pageBuilder: (context,state){
          debugPrint('config page : scannedCodeDataScreen');
          final uri = state.extra;
          return MaterialPage(child: ScannedQRCodeData(uri: Uri.parse(uri.toString())));
        },
      ),
    ],
  );
}