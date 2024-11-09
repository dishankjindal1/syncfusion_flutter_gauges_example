import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pulgas_power/core/reusable.dart';
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16.0),
        child: ref.watch(dailyDataProvider).when(
              data: (data) => RefreshIndicator(
                onRefresh: () async {
                  ref.invalidate(dailyDataProvider);
                  await Future.delayed(const Duration(seconds: 1));
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  clipBehavior: Clip.none,
                  child: Column(
                    children: [
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
                                    color:
                                        const Color.fromRGBO(228, 228, 228, 1),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Text(
                                    row.$2,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ]),
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
                      Image.network('https://picsum.photos/1920/1080')
                    ],
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
    );
  }
}
