import 'package:flutter/material.dart';
import 'package:pulgas_power/flow/view/pages/daily_page/daily_page.dart';
import 'package:pulgas_power/flow/view/pages/login_page/view/login_page.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final data = [
      (
        'Daily',
        () {
          PPDailyPage.push(context);
        }
      ),
      ('Logs', () {}),
      ('Settings', () {}),
      (
        'Logout',
        () {
          while (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
          PPLoginPage.pushReplacement(context);
        }
      ),
    ];
    return Drawer(
      child: ListView.separated(
        itemBuilder: (context, index) {
          final (msg, fn) = data[index];
          return ListTile(
            onTap: fn,
            title: Text(msg),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
        itemCount: data.length,
      ),
    );
  }
}
