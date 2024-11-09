import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pulgas_power/flow/view/pages/daily_page/daily_page.dart';
import 'package:pulgas_power/flow/view/pages/live_page/info_guage.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pulgas_power/flow/view/pods/live_data/live_data_pod.dart';

class PPLivePage extends ConsumerStatefulWidget {
  const PPLivePage({super.key});

  static push(final BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const PPDailyPage();
    }));
  }

  @override
  ConsumerState<PPLivePage> createState() => _PPLivePageState();
}

class _PPLivePageState extends ConsumerState<PPLivePage> {
  final ScrollController scrollController = ScrollController();
  bool isEdge = false;
  DateTime reportedAd = DateTime.now();
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

  void infinteLoop() async {
    await Future.delayed(const Duration(seconds: 10));

    ref.invalidate(liveDataProvider);
    reportedAd = DateTime.now();

    infinteLoop();
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
        actions: [
          IconButton(
            onPressed: () {
              PPDailyPage.push(context);
            },
            icon: const Icon(
              Icons.menu,
            ),
          )
        ],
      ),
      body: ref.watch(liveDataProvider).when(
          data: (data) {
            return Center(
              child: Column(
                children: [
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        ref.invalidate(liveDataProvider);
                        await Future.delayed(const Duration(seconds: 1));
                      },
                      child: SingleChildScrollView(
                        controller: scrollController,
                        physics: const AlwaysScrollableScrollPhysics(),
                        clipBehavior: Clip.none,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AnimationLimiter(
                            child: Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: List.generate(
                                data.length,
                                (index) => AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: const Duration(milliseconds: 600),
                                  child: SlideAnimation(
                                    verticalOffset: 400.0,
                                    child: ScaleAnimation(
                                      child: FadeInAnimation(
                                        child: PPInfoGuage(data: data[index]),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      boxShadow: isEdge ? null : kElevationToShadow[4],
                    ),
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
                            data[0].displayReportedAt,
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
          error: (_, __) => const Center(
                child: Text('Try again later'),
              ),
          loading: () => const Center(
                child: CircularProgressIndicator.adaptive(),
              )),
    );
  }
}
