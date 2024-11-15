import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:pulgas_power/core/mixin/app_storage_mixin.dart';
import 'package:pulgas_power/core/theme/theme.dart';
import 'package:pulgas_power/flow/view/pages/main/app_drawer.dart';
import 'package:pulgas_power/flow/view/view_models/logs/logs_viewmodel.dart';

class PPLogsPage extends ConsumerWidget with AppStorageMixin {
  const PPLogsPage({super.key});

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
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
              Container(
                padding: const EdgeInsets.all(20),
                color: const Color(PPTheme.greyColor),
                child: const Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Text(
                          'Data/Time',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                    Gap(8),
                    Expanded(
                        child: Text(
                      'Type',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    Gap(8),
                    Expanded(
                        flex: 3,
                        child: Text(
                          'Log Entry',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                  ],
                ),
              ),
              Expanded(
                child: SafeArea(
                  child: RefreshIndicator.adaptive(
                    onRefresh: () async {
                      ref.invalidate(const LogsViewModelFamily());
                    },
                    child: ListView.builder(
                      addAutomaticKeepAlives: false,
                      itemBuilder: (context, index) {
                        const pageLimit = 20;
                        final pageNumber = index ~/ pageLimit;
                        final indexInPage = index % pageLimit;

                        final response = ref.watch(LogsViewModelProvider(
                          pageNumber,
                          pageLimit,
                        ));

                        return response.when(
                          data: (data) {
                            final (date, type, entry) = data.data![indexInPage];
                            return Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: index.isOdd
                                    ? const Color(PPTheme.greyColor)
                                        .withOpacity(0.5)
                                    : Colors.white,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 2,
                                      child: Text(
                                        DateFormat('dd-MM-yyyy hh:mm')
                                            .format(DateTime.parse(date)),
                                      )),
                                  const Gap(8),
                                  Expanded(
                                      child: Text(
                                    type,
                                  )),
                                  const Gap(8),
                                  Expanded(
                                      flex: 3,
                                      child: Text(
                                        entry,
                                      )),
                                ],
                              ),
                            );
                          },
                          error: (_, __) => indexInPage == 0
                              ? const Center(child: Text('Try Again'))
                              : const SizedBox.shrink(),
                          loading: () => indexInPage == 0
                              ? const SizedBox(
                                  height: 48,
                                  child: Center(
                                    child: CircularProgressIndicator.adaptive(),
                                  ))
                              : null,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
