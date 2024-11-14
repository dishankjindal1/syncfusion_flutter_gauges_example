import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pulgas_power/core/mixin/app_storage_mixin.dart';
import 'package:pulgas_power/core/theme/theme.dart';
import 'package:pulgas_power/flow/view/pages/main/app_drawer.dart';
import 'package:pulgas_power/flow/view/pages/main/setting_page/input_widget.dart';
import 'package:pulgas_power/flow/view/view_models/setting/setting_viewmodel.dart';

class PPSettingPage extends ConsumerWidget with AppStorageMixin {
  const PPSettingPage({super.key});

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final entity = ref.watch(settingViewModelProvider);

    return Scaffold(
      backgroundColor: const Color(PPTheme.appBgColor),
      appBar: AppBar(
        backgroundColor: const Color(PPTheme.appBarColor),
        centerTitle: false,
        title: const Text.rich(
          TextSpan(children: [
            TextSpan(text: 'Pulgas'),
            TextSpan(
              text: 'Power',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ]),
          style: TextStyle(
            color: Color(PPTheme.appBarHeaderColor),
            fontSize: 24,
          ),
        ),
        actions: [
          Builder(builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
              icon: const Icon(Icons.menu),
            );
          }),
        ],
      ),
      endDrawer: const AppDrawer(),
      body: Align(
        alignment: Alignment.topCenter,
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 500,
          ),
          child: Column(
            children: [
              InputWidget(
                label: 'Remote IP',
                value: entity.remoteIp,
                callback: (final String? value) {
                  ref
                      .read(settingViewModelProvider.notifier)
                      .update(entity.copyWith(
                        remoteIp: value,
                      )..save());
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text('Updated!')));
                },
              ),
              InputWidget(
                label: 'Remote PORT',
                value: entity.remotePort,
                callback: (value) {
                  ref
                      .read(settingViewModelProvider.notifier)
                      .update(entity.copyWith(
                        remotePort: value,
                      )..save());
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text('Updated!')));
                },
              ),
              InputWidget(
                type: TextInputType.phone,
                label: 'Live Data Interval (in Seconds)',
                value: entity.liveDataInterval.inSeconds.toString(),
                callback: (value) {
                  ref
                      .read(settingViewModelProvider.notifier)
                      .update(entity.copyWith(
                        liveDataInterval: Duration(seconds: int.parse(value!)),
                      )..save());
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text('Updated!')));
                },
              ),
              InputWidget(
                type: TextInputType.phone,
                label: 'Daily Figures Interval (in Seconds)',
                value: entity.dailyFigureInterval.inSeconds.toString(),
                callback: (value) {
                  ref
                      .read(settingViewModelProvider.notifier)
                      .update(entity.copyWith(
                        dailyFigureInterval:
                            Duration(seconds: int.parse(value!)),
                      )..save());
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text('Updated!')));
                },
              ),
              InputWidget(
                type: TextInputType.phone,
                label: 'Graphs Interval (in Seconds)',
                value: entity.graphFigureInterval.inSeconds.toString(),
                callback: (value) {
                  ref
                      .read(settingViewModelProvider.notifier)
                      .update(entity.copyWith(
                        graphFigureInterval:
                            Duration(seconds: int.parse(value!)),
                      )..save());
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text('Updated!')));
                },
              ),
              InputWidget(
                type: TextInputType.phone,
                label: 'Logs Interval (in Seconds)',
                value: entity.logsInterval.inSeconds.toString(),
                callback: (value) {
                  ref
                      .read(settingViewModelProvider.notifier)
                      .update(entity.copyWith(
                        logsInterval: Duration(seconds: int.parse(value!)),
                      )..save());
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text('Updated!')));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
