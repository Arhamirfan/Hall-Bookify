import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hall_bookify/Screens/loginScreens/getStartedScreen.dart';
import 'package:provider/provider.dart';

import 'Models/FacebookLogin.dart';
import 'Models/GoogleLogin.dart';
import 'Models/phoneAuth.dart';
import 'Screens/loginScreens/SplashScreen.dart';
import 'Screens/loginScreens/ageConfirmation.dart';
import 'Screens/loginScreens/registerPhone.dart';
import 'Screens/loginScreens/registerSocialMedia.dart';
import 'Screens/mainScreens/MainMenu.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => phoneAuthentication()),
        ChangeNotifierProvider(create: (context) => getnames()),
        ChangeNotifierProvider(create: (context) => Facebooklogin()),
        ChangeNotifierProvider(create: (context) => Googlelogin()),
      ],
      child: MaterialApp(
        title: 'Hall Bookify',
        theme: ThemeData(fontFamily: 'Gudea'),
        initialRoute: SplashScreen.id,
        routes: {
          SplashScreen.id: (context) => SplashScreen(),
          getStartedScreen.id: (context) => getStartedScreen(),
          registerPhone.id: (context) => registerPhone(),
          registerSocialMedia.id: (context) => registerSocialMedia(),
          //registerSocialMediaData.id: (context) => registerSocialMediaData(),
          // phoneOTPverification.id: (context) => phoneOTPverification(),
          ageConfirmation.id: (context) => ageConfirmation(),
          //____________________________________________
          MainMenu.id: (context) => MainMenu(),
          //ProfileManagement.id: (context) => ProfileManagement(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
