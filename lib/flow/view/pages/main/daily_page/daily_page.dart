import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:pulgas_power/core/theme/theme.dart';
import 'package:pulgas_power/flow/view/pages/main/app_drawer.dart';
import 'package:pulgas_power/flow/view/pages/main/daily_page/info_linear.dart';
import 'package:pulgas_power/flow/view/view_models/daily/daily_viewmodel.dart';
import 'package:pulgas_power/flow/view/view_models/setting/setting_viewmodel.dart';
import 'package:super_tooltip/super_tooltip.dart';

class PPDailyPage extends ConsumerStatefulWidget {
  const PPDailyPage({super.key});

  @override
  ConsumerState<PPDailyPage> createState() => _PPDailyPageState();
}

class _PPDailyPageState extends ConsumerState<PPDailyPage> {
  final scrollController = ScrollController();
  final infoLinearData = [
    (8.5, 'Stop Gen\n08:30', SuperTooltipController()),
    (20.0, 'Now\n20:00', SuperTooltipController()),
  ];
  bool isEdge = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        infinteLoop();
        scrollController.addListener(detectEdge);
      },
    );
  }

  void infinteLoop() async {
    ref.invalidate(dailyViewModelProvider);

    await Future.delayed(
        ref.read(settingViewModelProvider).dailyFigureInterval);

    if (mounted) {
      infinteLoop();
    }
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
    infoLinearData.map((e) => e.$3.dispose());
    scrollController.removeListener(detectEdge);
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
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
      onEndDrawerChanged: (isOpened) {
        if (mounted) {
          setState(() {
            if (isOpened) {
              infoLinearData.map((e) => e.$3.hideTooltip());
            } else {
              infoLinearData.map((e) => e.$3.showTooltip());
            }
          });
        }
      },
      endDrawer: const AppDrawer(),
      body: Scrollbar(
        controller: scrollController,
        child: ref.watch(dailyViewModelProvider).when(
              data: (data) => Column(
                children: [
                  Expanded(
                    child: RefreshIndicator.adaptive(
                      onRefresh: () async {
                        ref.invalidate(dailyViewModelProvider);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16.0,
                        ).copyWith(top: 8),
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
                                    InfoLinear(data: infoLinearData),
                                    const Gap(8),
                                    Image.network(
                                        'https://picsum.photos/1920/1080'),
                                    const Gap(24),
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(PPTheme.appBgColor),
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
                  ),
                ],
              ),
              error: (_, __) => Center(
                child: CupertinoButton.filled(
                  onPressed: () {
                    ref.invalidate(dailyViewModelProvider);
                  },
                  child: const Text('Try Again'),
                ),
              ),
              loading: () => const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            ),
      ),
    );
  }
}
