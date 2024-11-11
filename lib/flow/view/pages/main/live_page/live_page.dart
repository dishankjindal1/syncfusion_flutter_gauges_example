import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pulgas_power/flow/view/pages/main/live_page/info_guage.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pulgas_power/flow/view/view_models/live/live_viewmodel.dart';

class PPLivePage extends ConsumerStatefulWidget {
  const PPLivePage({super.key});

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

    if (mounted) {
      ref.invalidate(liveViewModelProvider);
      reportedAd = DateTime.now();

      infinteLoop();
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
    final ar = MediaQuery.sizeOf(context).aspectRatio;

    final isPortrait = ar < 1;

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
        child: ref.watch(liveViewModelProvider).when(
              data: (data) {
                return Column(
                  children: [
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          ref.invalidate(liveViewModelProvider);
                          await Future.delayed(const Duration(seconds: 1));
                        },
                        child: ScrollConfiguration(
                          behavior: ScrollConfiguration.of(context)
                              .copyWith(scrollbars: false),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              constraints: const BoxConstraints(maxWidth: 1000),
                              child: AnimationLimiter(
                                child: GridView.builder(
                                  clipBehavior: Clip.none,
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  controller: scrollController,
                                  shrinkWrap: true,
                                  itemCount: data.listOfData.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: isPortrait ? 2 : 4,
                                  ),
                                  itemBuilder: (final context, final index) {
                                    final (type, value, valueWithSymbol) =
                                        data.listOfData[index];

                                    return AnimationConfiguration.staggeredList(
                                      position: index,
                                      duration:
                                          const Duration(milliseconds: 600),
                                      child: SlideAnimation(
                                        verticalOffset: 400.0,
                                        child: ScaleAnimation(
                                          child: FadeInAnimation(
                                            child: PPInfoGuage(
                                              type: type,
                                              value: value,
                                              valueWithSymbol: valueWithSymbol,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 8),
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
                );
              },
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
