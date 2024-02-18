import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/BookTour/bookTour.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:flutter_auth/Screens/Signup/signup_screen.dart';
import 'package:flutter_auth/Screens/Welcome/welcome_screen.dart';
import 'package:flutter_auth/Screens/chat/chat.dart';
import 'package:flutter_auth/Screens/homepage/description.dart';
import 'package:flutter_auth/Screens/homepage/home.dart';
import 'package:flutter_auth/Screens/navbar/bottom_bar.dart';
import 'package:flutter_auth/Screens/notification/notification_service.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/firebase_options.dart';
import 'package:flutter_auth/locale/locale.dart';
import 'package:flutter_auth/locale/locale_controller.dart';
import 'package:flutter_auth/services/services.dart';
import 'package:flutter_auth/strip_payment/strip_keys.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

void main() async {
  // Stripe.publishableKey = ApiKeys.publishableKey;
  await initializeDateFormatting('hu_HU', null);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationService.initializeNotification();
  runApp(
    ChangeNotifierProvider(
      create: (context) => Services(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(MylocalController());

    return GetMaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: kPrimaryColor,
            scaffoldBackgroundColor: Colors.white,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                textStyle: TextStyle(color: Colors.white),
                elevation: 0,
                primary: kPrimaryColor,
                shape: const StadiumBorder(),
                maximumSize: const Size(double.infinity, 56),
                minimumSize: const Size(double.infinity, 56),
              ),
            ),
            inputDecorationTheme: const InputDecorationTheme(
              filled: true,
              fillColor: kPrimaryLightColor,
              iconColor: kPrimaryColor,
              prefixIconColor: kPrimaryColor,
              contentPadding: EdgeInsets.symmetric(
                  horizontal: defaultPadding, vertical: defaultPadding),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide.none,
              ),
            )),
        locale: Get.deviceLocale,
        translations: Mylocal(),
        home: Scaffold(
          body: LoginScreen(),
        ));
  }
}
