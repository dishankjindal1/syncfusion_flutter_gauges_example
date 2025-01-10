import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:pulgas_power/core/auth/auth_data.dart';
import 'package:pulgas_power/core/mixin/app_storage_mixin.dart';
import 'package:pulgas_power/di.dart';
import 'package:pulgas_power/flow/view/app.dart';
import 'package:pulgas_power/flow/view/pods/nav/nav_index_pod.dart';

class AppDrawer extends ConsumerWidget with AppStorageMixin {
  const AppDrawer({super.key});

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final isPortrait = MediaQuery.sizeOf(context).aspectRatio < 1;

    final list = [
      (Icons.home, 'Live Figures'),
      (Icons.sunny, 'Daily Figures'),
      (Icons.monitor, 'Logs'),
      (Icons.settings, 'Settings'),
    ];

    main() => Material(
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
              for (final (index, (icon, title)) in list.indexed) ...[
                const Divider(),
                ListTile(
                  onTap: () {
                    ref.read(navIndexPodProvider.notifier).updateIndex(index);
                    Navigator.pop(context);
                  },
                  leading: Icon(icon),
                  title: Text(
                    title,
                    style: ref.read(navIndexPodProvider) == index
                        ? const TextStyle(
                            fontWeight: FontWeight.bold,
                          )
                        : null,
                  ),
                ),
              ],
              const Divider(),
              if (isPortrait) const Spacer(),
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
              ),
              const Gap(24),
            ],
          ),
        );

    if (isPortrait) {
      return FractionallySizedBox(widthFactor: 0.6, child: main());
    }
    return SingleChildScrollView(
      child: FractionallySizedBox(widthFactor: 0.3, child: main()),
    );
  }
}
