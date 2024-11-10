import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pulgas_power/di.dart';
import 'package:pulgas_power/flow/view/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dependencyInjection();

  runApp(const ProviderScope(child: PPApp()));
}
