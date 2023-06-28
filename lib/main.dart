import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:userapp/assistantMethods/cart_changer.dart';
import 'package:userapp/assistantMethods/cart_item_counter.dart';
import 'package:userapp/assistantMethods/total_amount.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:userapp/global/global.dart';
import 'package:userapp/splashScreen/my_splash_screen.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'Services/notifi_service.dart';
import 'assistantMethods/address_changer.dart';

Future<void> main()  async
{
  WidgetsFlutterBinding.ensureInitialized();





  NotificationService().initNotification();

  tz.initializeTimeZones();

  sharedPreferences = await SharedPreferences.getInstance();

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:
      [
        ChangeNotifierProvider(create: (c)=> CartItemCounter()),
        ChangeNotifierProvider(create: (c)=> TotalAmount()),
        ChangeNotifierProvider(create: (c)=> AddressChanger()),
        ChangeNotifierProvider(create: (c)=> CartChanger()),
      ],
      child: MaterialApp(
        title: 'Users App',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        debugShowCheckedModeBanner: false,
        home: MySplashScreen(),
      ),
    );
  }
}

