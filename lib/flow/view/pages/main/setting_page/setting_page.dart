import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:pulgas_power/core/auth/auth_data.dart';
import 'package:pulgas_power/core/mixin/app_storage_mixin.dart';
import 'package:pulgas_power/flow/view/app.dart';
import 'package:pulgas_power/flow/view/pages/main/setting_page/input_widget.dart';
import 'package:pulgas_power/flow/view/view_models/setting/setting_viewmodel.dart';

class PPSettingPage extends ConsumerWidget with AppStorageMixin {
  const PPSettingPage({super.key});

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final entity = ref.watch(settingViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text.rich(
          TextSpan(children: [
            TextSpan(text: 'Pulgas'),
            TextSpan(
              text: 'Power',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ]),
          style: TextStyle(fontSize: 24),
        ),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 500,
          ),
          child: Column(
            children: [
              InputWidget(
                isMandatory: true,
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
                isMandatory: false,
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
              const Spacer(),
              const Gap(16),
              Builder(builder: (context) {
                return Container(
                  color: Colors.transparent,
                  width: double.maxFinite,
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      fixedSize:
                          WidgetStateProperty.all(const Size.fromHeight(48)),
                      backgroundColor: WidgetStateProperty.all(Colors.white),
                      overlayColor: WidgetStateProperty.all(Colors.yellow),
                      elevation: WidgetStateProperty.all(10),
                    ),
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
                    child: const Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }),
              const Gap(16),
            ],
          ),
        ),
      ),
    );
  }
}
