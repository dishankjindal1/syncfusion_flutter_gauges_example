import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:pulgas_power/flow/view/pages/main/daily_page/info_linear.dart';
import 'package:pulgas_power/flow/view/view_models/daily/daily_viewmodel.dart';

class PPDailyPage extends ConsumerStatefulWidget {
  const PPDailyPage({super.key});

  static push(final BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
        pageBuilder: (context, a, b) => const PPDailyPage(),
      ),
    );
  }

  @override
  ConsumerState<PPDailyPage> createState() => _PPDailyPageState();
}

class _PPDailyPageState extends ConsumerState<PPDailyPage> {
  final scrollController = ScrollController();
  bool isEdge = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        scrollController.addListener(detectEdge);
      },
    );
  }

  void detectEdge() {
    if (scrollController.position.atEdge && scrollController.offset > 0) {
      if (mounted && !isEdge) {
        setState(() {
          isEdge = true;
        });
      }
    } else {
      if (mounted && isEdge) {
        setState(() {
          isEdge = false;
        });
      }
    }
  }

  @override
  void dispose() {
    scrollController.removeListener(detectEdge);
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
        child: ref.watch(dailyViewModelProvider).when(
              data: (data) => Column(
                children: [
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        ref.invalidate(dailyViewModelProvider);
                        await Future.delayed(const Duration(seconds: 1));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 16.0),
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
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            TableCell(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: const Color.fromRGBO(
                                                      228, 228, 228, 1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
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
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.0),
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
                                    Image.network(
                                        'https://picsum.photos/1920/1080')
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      boxShadow: isEdge ? null : kElevationToShadow[4],
                    ),
                    child: SafeArea(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Last Update:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(228, 228, 228, 1),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Text(
                              data.displayReportedAt,
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
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
