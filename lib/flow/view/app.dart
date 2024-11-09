import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:pulgas_power/flow/view/pages/live_page/live_page.dart';

class PPApp extends StatefulWidget {
  const PPApp({super.key});

  @override
  State<PPApp> createState() => _PPAppState();
}

class _PPAppState extends State<PPApp> {
  @override
  void initState() {
    super.initState();

    FlutterDisplayMode.setHighRefreshRate();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pulgas Power',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            color: Colors.amber,
          )),
      home: const PPLivePage(),
    );
  }
}
