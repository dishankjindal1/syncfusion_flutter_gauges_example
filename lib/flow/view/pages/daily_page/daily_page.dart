import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:pulgas_power/core/reusable.dart';
import 'package:pulgas_power/flow/view/pages/daily_page/info_linear.dart';
import 'package:pulgas_power/flow/view/pods/daily_data/daily_data_pod.dart';

class PPDailyPage extends ConsumerStatefulWidget {
  const PPDailyPage({super.key});

  static push(final BuildContext context) {
    Navigator.push(context, PageRouteBuilder(pageBuilder: (context, a, b) {
      return SlideTransition(
        position: PProuterReuseable.rightToLeftTransition.animate(a),
        child: const PPDailyPage(),
      );
    }));
  }

  @override
  ConsumerState<PPDailyPage> createState() => _PPDailyPageState();
}

class _PPDailyPageState extends ConsumerState<PPDailyPage> {
  final scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
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
      body: Scrollbar(
        controller: scrollController,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16.0),
          child: ref.watch(dailyDataProvider).when(
                data: (data) => RefreshIndicator(
                  onRefresh: () async {
                    ref.invalidate(dailyDataProvider);
                    await Future.delayed(const Duration(seconds: 1));
                  },
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context)
                        .copyWith(scrollbars: false),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      clipBehavior: Clip.none,
                      child: Center(
                        child: Container(
                          constraints: const BoxConstraints(
                            maxWidth: 500,
                          ),
                          child: Column(
                            children: [
                              const Divider(),
                              Table(
                                columnWidths: const {
                                  0: FlexColumnWidth(3),
                                  1: FlexColumnWidth(2),
                                },
                                children: [
                                  for (final row in data.listOfData) ...[
                                    TableRow(children: [
                                      TableCell(
                                        child: Text(
                                          row.$1,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      TableCell(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: const Color.fromRGBO(
                                                228, 228, 228, 1),
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                          child: Text(
                                            row.$2,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ]),
                                    if (data.listOfData.last != row)
                                      const TableRow(children: [
                                        TableCell(
                                          child: SizedBox.square(
                                            dimension: 8,
                                          ),
                                        ),
                                        TableCell(
                                          child: SizedBox.square(
                                            dimension: 8,
                                          ),
                                        ),
                                      ]),
                                  ],
                                ],
                              ),
                              const Divider(),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                child: Text(
                                  'Solar/Generator Run',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const Gap(60),
                              const InfoLinear(),
                              const Gap(8),
                              Image.network('https://picsum.photos/1920/1080')
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                error: (_, __) => const Center(
                  child: Text('Try again later'),
                ),
                loading: () => const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              ),
        ),
      ),
    );
  }
}
