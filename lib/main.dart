
import 'package:exp/app_screens/card.dart';
import 'package:exp/app_screens/cart.dart';
import 'package:exp/app_screens/checkout_page.dart';
import 'package:exp/app_screens/details_screen.dart';
import 'package:exp/app_screens/testing.dart';
import 'package:exp/model_classes/category_list.dart';
import 'package:exp/provider/cart_provider.dart';
import 'package:exp/provider/counter%20provider.dart';
import 'package:exp/provider/stock_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'app_screens/login and signup page.dart';
import 'app_screens/maps_page.dart';
import 'app_screens/splash screen.dart';
import 'app_screens/Inventory.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => StockProvider()),
        ChangeNotifierProvider(create: (_) => counter_provider()),
        ChangeNotifierProvider(create: (_) => cart_provider()),
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
      home:Checkout()

    );
  }
}

