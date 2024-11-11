import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pulgas_power/core/auth/auth_data.dart';
import 'package:pulgas_power/core/mixin/app_storage_mixin.dart';
import 'package:pulgas_power/flow/view/pages/main/live_page/live_page.dart';
import 'package:pulgas_power/flow/view/pages/main/logs_page/logs_page.dart';
import 'package:pulgas_power/flow/view/pages/main/nav_module.dart';
import 'package:pulgas_power/flow/view/pages/login/login_page.dart';
import 'package:pulgas_power/flow/view/pages/main/daily_page/daily_page.dart';
import 'package:pulgas_power/flow/view/pages/main/setting_page/setting_page.dart';
import 'package:pulgas_power/flow/view/view_models/nav/nav_viewmodel.dart';

class PPApp extends StatelessWidget {
  const PPApp({super.key});

  @override
  Widget build(final BuildContext context) {
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
      home: const PPMain(),
    );
  }
}

class PPMain extends ConsumerWidget with AppStorageMixin {
  const PPMain({super.key});

  static pushReplacement(final BuildContext context) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(pageBuilder: (context, a, b) => const PPMain()),
    );
  }

  static const _pages = [
    PPLivePage(),
    PPDailyPage(),
    PPLogsPage(),
    PPSettingPage(),
  ];

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    return getRef<AuthData>().isAuthorized
        ? Scaffold(
            body: Row(
              children: [
                const NavModule.landscape(),
                Expanded(child: _pages[ref.watch(navViewModelProvider)]),
              ],
            ),
            bottomNavigationBar: const NavModule.portrait(),
          )
        : const PPLoginPage();
  }
}
