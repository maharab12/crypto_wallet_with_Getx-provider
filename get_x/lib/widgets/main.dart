import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'package:get_x/pages/home_page.dart';
import 'package:get_x/widgets/utils.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  await registerServives();
  await registerController();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 58, 183, 68)),
          textTheme: GoogleFonts.quicksandTextTheme()),
      routes: {
        "/home": (context) => Homepage(),
      },
      initialRoute: "/home",
    );
  }
}
