import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pulgas_power/flow/view/pages/main/live_page/live_page.dart';
import 'package:pulgas_power/flow/view/pages/main/daily_page/daily_page.dart';
import 'package:pulgas_power/flow/view/pages/main/setting_page/setting_page.dart';
import 'package:pulgas_power/flow/view/pods/nav/nav_index_pod.dart';

class NavModule extends ConsumerWidget {
  const NavModule.portrait({super.key}) : isPortrait = true;
  const NavModule.landscape({super.key}) : isPortrait = false;

  final bool isPortrait;

  static const _pages = [
    (PPLivePage(), 'Live', Icons.home),
    (PPDailyPage(), 'Daily', Icons.sunny),
    (PPDailyPage(), 'Logs', Icons.monitor),
    (PPSettingPage(), 'Settings', Icons.settings),
  ];

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    if (isPortrait) {
      return MediaQuery.sizeOf(context).aspectRatio < 1
          ? BottomNavigationBar(
              showSelectedLabels: true,
              showUnselectedLabels: true,
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.black26,
              currentIndex: ref.watch(navIndexPodProvider),
              items: _pages
                  .map(
                    (e) => BottomNavigationBarItem(
                      label: e.$2,
                      icon: Icon(
                        e.$3,
                        color: Colors.black26,
                      ),
                      activeIcon: Icon(
                        e.$3,
                        color: Theme.of(context).appBarTheme.backgroundColor,
                        // shadows: kElevationToShadow[1],
                      ),
                    ),
                  )
                  .toList(),
              onTap: ref.read(navIndexPodProvider.notifier).updateIndex,
            )
          : const SizedBox.shrink();
    } else {
      return MediaQuery.sizeOf(context).aspectRatio > 1
          ? NavigationRail(
              destinations: _pages
                  .map(
                    (e) => NavigationRailDestination(
                      icon: Icon(
                        e.$3,
                        color: Colors.black,
                      ),
                      selectedIcon: Icon(
                        e.$3,
                        color: Theme.of(context).appBarTheme.backgroundColor,
                      ),
                      label: Text(e.$2),
                    ),
                  )
                  .toList(),
              selectedIndex: ref.watch(navIndexPodProvider),
              onDestinationSelected:
                  ref.read(navIndexPodProvider.notifier).updateIndex,
            )
          : const SizedBox.shrink();
    }
  }
}
