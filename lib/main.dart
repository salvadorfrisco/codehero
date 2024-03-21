import 'package:flutter/material.dart';
import 'package:hero/features/heroes/presenter/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFD42026),
        primaryColorDark: const Color(0xFF4E4E4E),
        primaryColorLight: const Color(0xFFFFFFFF),
        textTheme: const TextTheme(
            bodyLarge: TextStyle(
              fontSize: 21,
              color: Color(0xFF4E4E4E),
            ),
            bodyMedium: TextStyle(
              color: Color(0x00000fff),
              fontSize: 16,
              fontFamily: 'Roboto-Regular',
              letterSpacing: 0,
              height: 1.2,
            ),
            titleLarge: TextStyle(
              color: Color(0xFFD42026),
              fontSize: 16,
              fontFamily: 'Roboto-Black',
              fontWeight: FontWeight.bold,
              letterSpacing: 0,
              height: 1.2,
            ),
            titleMedium: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 16,
              fontFamily: 'Roboto-Regular',
              fontWeight: FontWeight.normal,
              letterSpacing: 0,
              height: 1.2,
            ),
            titleSmall: TextStyle(
              color: Color(0xFFD42026),
              fontSize: 16,
              fontFamily: 'Roboto-Light',
              fontWeight: FontWeight.normal,
              letterSpacing: 0,
              height: 1.2,
            )),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
