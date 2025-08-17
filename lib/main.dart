import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

import 'package:flutter_coworkers/config/app_color.dart';
import 'package:flutter_coworkers/config/appwrite.dart';
import 'package:flutter_coworkers/config/enums.dart';
import 'package:flutter_coworkers/data/models/worker_model.dart';
import 'package:flutter_coworkers/pages/booking_page.dart';
import 'package:flutter_coworkers/pages/checkout_page.dart';
import 'package:flutter_coworkers/pages/dashboard.dart';
import 'package:flutter_coworkers/pages/get_started_page.dart';
import 'package:flutter_coworkers/pages/list_worker_page.dart';
import 'package:flutter_coworkers/pages/sign_in_page.dart';
import 'package:flutter_coworkers/pages/sign_up_page.dart';
import 'package:flutter_coworkers/pages/success_booking_page.dart';
import 'package:flutter_coworkers/pages/worker_profile_page.dart';
import 'package:flutter_coworkers/pages/notifications_page.dart';
import 'package:flutter_coworkers/config/preferences.dart';

import 'config/app_translation.dart';
import 'config/session.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  Appwrite.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true).copyWith(
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.poppinsTextTheme().apply(
          bodyColor: AppColor.text,
          displayColor: AppColor.text,
        ),
        primaryColor: AppColor.primary,
        colorScheme: const ColorScheme.light(primary: AppColor.primary),
        filledButtonTheme: const FilledButtonThemeData(
          style: ButtonStyle(
            minimumSize: WidgetStatePropertyAll(Size.fromHeight(52)),
            textStyle: WidgetStatePropertyAll(
              TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            minimumSize: const WidgetStatePropertyAll(Size.fromHeight(52)),
            textStyle: const WidgetStatePropertyAll(
              TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            foregroundColor: const WidgetStatePropertyAll(AppColor.primary),
            side: const WidgetStatePropertyAll(
              BorderSide(color: AppColor.border, width: 1),
            ),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
            ),
          ),
        ),
      ),
      darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
        scaffoldBackgroundColor: const Color(0xff151317),
        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
        colorScheme: const ColorScheme.dark(primary: AppColor.primary),
        filledButtonTheme: const FilledButtonThemeData(
          style: ButtonStyle(
            minimumSize: WidgetStatePropertyAll(Size.fromHeight(52)),
            textStyle: WidgetStatePropertyAll(
              TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            minimumSize: const WidgetStatePropertyAll(Size.fromHeight(52)),
            textStyle: const WidgetStatePropertyAll(
              TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            foregroundColor: const WidgetStatePropertyAll(AppColor.primary),
            side: const WidgetStatePropertyAll(
              BorderSide(color: Color(0xff38333A), width: 1),
            ),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
            ),
          ),
        ),
      ),
      themeMode: Preferences.getThemeMode(),
      translations: AppTranslations(),
      locale: Preferences.getLocale() ??
          Get.deviceLocale ??
          const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
      initialRoute: AppRoute.dashboard.path,
      getPages: [
        GetPage(
            name: AppRoute.getStarted.path, page: () => const GetStartedPage()),
        GetPage(name: AppRoute.signUp.path, page: () => const SignUpPage()),
        GetPage(name: AppRoute.signIn.path, page: () => const SignInPage()),
        GetPage(
          name: AppRoute.dashboard.path,
          page: () {
            return FutureBuilder(
              future: AppSession.getUser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return DView.loadingCircle();
                }
                if (snapshot.data == null) {
                  return const GetStartedPage();
                }
                return const Dashboard();
              },
            );
          },
        ),
        GetPage(
          name: AppRoute.listWorker.path,
          page: () {
            final String category = Get.arguments as String;
            return ListWorkerPage(category: category);
          },
        ),
        GetPage(
          name: AppRoute.workerProfile.path,
          page: () {
            final WorkerModel worker = Get.arguments as WorkerModel;
            return WorkerProfilePage(worker: worker);
          },
        ),
        GetPage(
          name: AppRoute.booking.path,
          page: () {
            final WorkerModel worker = Get.arguments as WorkerModel;
            return BookingPage(worker: worker);
          },
        ),
        GetPage(name: AppRoute.checkout.path, page: () => const CheckoutPage()),
        GetPage(
            name: AppRoute.successBooking.path,
            page: () => const SuccessBookingPage()),
        GetPage(
          name: AppRoute.notifications.path,
          page: () => const NotificationsPage(),
        ),
      ],
    );
  }
}
