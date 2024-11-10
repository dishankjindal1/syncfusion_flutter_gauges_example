
import 'package:flutter/material.dart';
import 'package:pulgas_power/flow/view/pages/login_page/view/login_page.dart';

class PPApp extends StatefulWidget {
  const PPApp({super.key});

  @override
  State<PPApp> createState() => _PPAppState();
}

class _PPAppState extends State<PPApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pulgas Power',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          color: Colors.amber,
        ),
      ),
      home: const PPLoginPage(),
    );
  }
}
