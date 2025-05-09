
import 'package:exp/app_screens/admin.dart';
import 'package:exp/app_screens/card.dart';
import 'package:exp/app_screens/cart.dart';
import 'package:exp/app_screens/checkout_page.dart';
import 'package:exp/app_screens/details_screen.dart';
import 'package:exp/app_screens/test.dart';
import 'package:exp/model_classes/category_list.dart';
import 'package:exp/provider/oder_provider.dart';
import 'package:exp/provider/cart_provider.dart';
import 'package:exp/provider/counter%20provider.dart';
import 'package:exp/provider/stock_provider.dart';
import 'package:exp/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'app_screens/login and signup page.dart';
import 'app_screens/maps_page.dart';
import 'app_screens/splash screen.dart';
import 'app_screens/Inventory.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => StockProvider()),
        ChangeNotifierProvider(create: (_) => counter_provider()),
        ChangeNotifierProvider(create: (_) => cart_provider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => oder_provider()),
      ],
      child: MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
           fontFamily: 'Poppins',
        ),
      home:AuthScreen()


    );
  }
}

