import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pulgas_power/core/auth/auth_data.dart';
import 'package:pulgas_power/core/mixin/app_storage_mixin.dart';
import 'package:pulgas_power/flow/view/pages/main/live_page/live_page.dart';
import 'package:pulgas_power/flow/view/pages/main/logs_page/logs_page.dart';
import 'package:pulgas_power/flow/view/pages/login/login_page.dart';
import 'package:pulgas_power/flow/view/pages/main/daily_page/daily_page.dart';
import 'package:pulgas_power/flow/view/pages/main/setting_page/setting_page.dart';
import 'package:pulgas_power/flow/view/pods/nav/nav_index_pod.dart';

class PPApp extends StatelessWidget {
  const PPApp({super.key});

  @override
  Widget build(final BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoApp(
        title: 'Pulgas Power',
        color: Colors.white,
        builder: (context, child) {
          return ScaffoldMessenger(child: child!);
        },
        home: const PPMain(),
        localizationsDelegates: const [
          DefaultWidgetsLocalizations.delegate,
          DefaultMaterialLocalizations.delegate,
        ],
      );
    } else {
      return const MaterialApp(
        title: 'Pulgas Power',
        color: Colors.white,
        home: PPMain(),
        localizationsDelegates: [
          DefaultWidgetsLocalizations.delegate,
          DefaultMaterialLocalizations.delegate,
        ],
      );
    }
  }
}

class PPMain extends ConsumerWidget with AppStorageMixin {
  const PPMain({super.key});

  static pushReplacement(final BuildContext context) {
    Navigator.pushReplacement(
      context,
      Platform.isIOS
          ? CupertinoPageRoute(builder: (context) => const PPMain())
          : PageRouteBuilder(
              pageBuilder: (context, a, b) => const PPMain(),
            ),
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
        ? _pages[ref.watch(navIndexPodProvider)]
        : const PPLoginPage();
  }
}
