import 'package:flutter/material.dart';
import 'package:real_estate_app/core/constants/colors.dart';
import 'package:real_estate_app/features/home/navigation_menu.dart';

void main() {
  runApp(const RealEsateHomeApp());
}

class RealEsateHomeApp extends StatelessWidget {
  const RealEsateHomeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Real Estate App',
        theme: ThemeData(
          useMaterial3: false,
          fontFamily: 'Euclid',
          scaffoldBackgroundColor: Colors.white,
          colorScheme: ColorScheme.fromSeed(seedColor: kPrimaryColor),
        ),
        home: const NavigationMenu());
  }
}
