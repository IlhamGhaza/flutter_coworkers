import 'package:flutter/material.dart';
import 'config/appwrite.dart';
import 'config/extension/route_ext.dart';
import 'config/theme/app_theme.dart';
import 'presentation/login/onboarding.dart';
import 'presentation/login/signup.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Appwrite.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      // theme: ThemeData(
      //   useMaterial3: true,
      // ).copyWith(
      //   textTheme: GoogleFonts.poppinsTextTheme().apply(
      //     bodyColor: AppTheme.text,
      //     displayColor: AppTheme.text,
      //   ),
      //   primaryColor: AppTheme.primary,
      //   colorScheme: ColorScheme.light(primary: AppTheme.primary),
      // ),
      initialRoute: RouteExt.getStarted.name,
      routes: {
        RouteExt.getStarted.name: (context) => const Onboarding(),
        // RouteExt.login.name: (context) => const Login(),
        RouteExt.register.name: (context) => const Signup(),
        // RouteExt.forgotPassword.name: (context) => const ForgotPassword(),
        // RouteExt.resetPassword.name: (context) => const ResetPassword(),
        // RouteExt.verifyEmail.name: (context) => const VerifyEmail(),
        // RouteExt.dashboard.name: (context) => const Dashboard(),
        // RouteExt.listWorker.name: (context) => const ListWorker(),
        // RouteExt.booking.name: (context) => const Booking(),
        // RouteExt.checkout.name: (context) => const Checkout(),
        // RouteExt.successBooking.name: (context) => const SuccessBooking(),
        // RouteExt.userProfile.name: (context) => const UserProfile(),
        // RouteExt.worker.name: (context) => const Worker(),
      },
    );
  }
}
