import 'package:bluelight/Screens/HomeScreen.dart';
import 'package:bluelight/Screens/SettingsScreen.dart';
import 'package:flutter/material.dart';

class RouterClass {
  homeScreenRoute({required BuildContext context}) => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );

  settingsScreenRoute({required BuildContext context}) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SettingsScreen(),
        ),
      );
  //
  //
}
