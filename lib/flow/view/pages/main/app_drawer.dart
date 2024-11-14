import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pulgas_power/core/auth/auth_data.dart';
import 'package:pulgas_power/core/mixin/app_storage_mixin.dart';
import 'package:pulgas_power/di.dart';
import 'package:pulgas_power/flow/view/app.dart';
import 'package:pulgas_power/flow/view/pods/nav/nav_index_pod.dart';

class AppDrawer extends ConsumerWidget with AppStorageMixin {
  const AppDrawer({super.key});

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    return FractionallySizedBox(
      widthFactor: 0.5,
      child: Material(
        child: Column(
          children: [
            SafeArea(
              child: ListTile(
                leading: const CircleAvatar(child: Icon(Icons.person)),
                title: Text.rich(TextSpan(text: 'Welcome! ', children: [
                  TextSpan(
                    text: '${getIt<AuthData>().username ?? 'User'} ',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ])),
              ),
            ),
            const Divider(),
            ListTile(
              onTap: () {
                ref.read(navIndexPodProvider.notifier).updateIndex(0);
                Navigator.pop(context);
              },
              leading: const Icon(Icons.home),
              title: Text(
                'Live Figures',
                style: ref.read(navIndexPodProvider) == 0
                    ? const TextStyle(
                        fontWeight: FontWeight.bold,
                      )
                    : null,
              ),
            ),
            const Divider(),
            ListTile(
              onTap: () {
                ref.read(navIndexPodProvider.notifier).updateIndex(1);
                Navigator.pop(context);
              },
              leading: const Icon(Icons.sunny),
              title: Text(
                'Daily Figures',
                style: ref.read(navIndexPodProvider) == 1
                    ? const TextStyle(
                        fontWeight: FontWeight.bold,
                      )
                    : null,
              ),
            ),
            const Divider(),
            ListTile(
              onTap: () {
                ref.read(navIndexPodProvider.notifier).updateIndex(2);
                Navigator.pop(context);
              },
              leading: const Icon(Icons.monitor),
              title: Text(
                'Logs',
                style: ref.read(navIndexPodProvider) == 2
                    ? const TextStyle(
                        fontWeight: FontWeight.bold,
                      )
                    : null,
              ),
            ),
            const Divider(),
            ListTile(
              onTap: () {
                ref.read(navIndexPodProvider.notifier).updateIndex(3);
                Navigator.pop(context);
              },
              leading: const Icon(Icons.settings),
              title: Text(
                'Settings',
                style: ref.read(navIndexPodProvider) == 3
                    ? const TextStyle(
                        fontWeight: FontWeight.bold,
                      )
                    : null,
              ),
            ),
            const Divider(),
            const Spacer(),
            SafeArea(
              child: CupertinoButton.filled(
                onPressed: () {
                  getRef<AuthData>()
                    ..aKey = null
                    ..save().then((_) {
                      if (context.mounted) {
                        PPMain.pushReplacement(context);

                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Logged out!')));
                      }
                    });
                },
                child: const Text('Logout'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
