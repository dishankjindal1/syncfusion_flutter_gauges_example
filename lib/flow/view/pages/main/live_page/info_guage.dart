import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pulgas_power/flow/domain/enum/live_enums.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class PPInfoGuage extends StatelessWidget {
  const PPInfoGuage({
    required this.type,
    required this.value,
    required this.valueWithSymbol,
    super.key,
  });

  final LiveDataType type;
  final double value;
  final String valueWithSymbol;

  @override
  Widget build(BuildContext context) {
    final ar = MediaQuery.sizeOf(context).aspectRatio;

    final isPortrait = ar < 1;
    const gaugeWidth = 16.0;

    final needleLength = type.isBatterEnergy || type.startRange.isNegative
        ? isPortrait
            ? Platform.isAndroid
                ? 0.65
                : 0.7
            : Platform.isAndroid
                ? 0.5
                : 0.75
        : isPortrait
            ? Platform.isAndroid
                ? 0.665
                : 0.715
            : Platform.isAndroid
                ? 0.7
                : 0.765;

    return Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          boxShadow: kElevationToShadow[4],
        ),
        child: SfRadialGauge(
          enableLoadingAnimation: true,
          title: GaugeTitle(
            text: type.chartTitle,
          ),
          axes: [
            RadialAxis(
                canRotateLabels: true,
                minimum: type.startRange.toDouble(),
                maximum: type.endRange.toDouble(),
                maximumLabels: type.rangeType.isNoColor ? 6 : 3,
                numberFormat: NumberFormat.decimalPattern(),
                startAngle: 150,
                endAngle: 390,
                showLastLabel: true,
                showFirstLabel: true,
                labelsPosition: ElementsPosition.outside,
                ticksPosition: ElementsPosition.outside,
                axisLineStyle: const AxisLineStyle(
                  thickness: gaugeWidth,
                ),
                majorTickStyle: const MajorTickStyle(
                  length: 0,
                ),
                minorTickStyle: const MinorTickStyle(
                  length: 0,
                ),
                axisLabelStyle: const GaugeTextStyle(
                  fontSize: gaugeWidth * 0.5,
                ),
                ranges: [
                  if (type.rangeType.isNoColor)
                    GaugeRange(
                      startValue: type.startRange.toDouble(),
                      endValue: type.endRange.toDouble(),
                      startWidth: gaugeWidth,
                      endWidth: gaugeWidth,
                      color: Colors.white,
                    )
                  else ...[
                    if (type.rangeType.isMultiColor)
                      for (final range in type.ranges!)
                        GaugeRange(
                          startValue: range.$1.toDouble(),
                          endValue: range.$2.toDouble(),
                          startWidth: gaugeWidth,
                          endWidth: gaugeWidth,
                          color: range.$3,
                        )
                    else
                      GaugeRange(
                        startValue: 0,
                        endValue: value,
                        startWidth: gaugeWidth,
                        endWidth: gaugeWidth,
                        color: Colors.green,
                      ),

                    /// Add the black pointer on the guage strip
                    if (type.stickyPointerPosition != null)
                      GaugeRange(
                        startValue: type.stickyPointerPosition!.toDouble() -
                            (type.stickyPointerSize! ~/ 2),
                        endValue: type.stickyPointerPosition!.toDouble() +
                            (type.stickyPointerSize! ~/ 2),
                        startWidth: gaugeWidth,
                        endWidth: gaugeWidth,
                        color: Colors.black54,
                      )
                  ],
                ],
                pointers: [
                  NeedlePointer(
                    enableAnimation: true,
                    needleLength: needleLength,
                    value: value,
                    needleStartWidth: 0.5,
                    needleEndWidth: 2.5,
                  ),
                ],
                annotations: [
                  GaugeAnnotation(
                    widget: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                type.unitType.label,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: gaugeWidth * 0.75,
                                ),
                              ),
                            ),
                            Text(
                              valueWithSymbol,
                              style: const TextStyle(
                                fontSize: gaugeWidth * 0.75,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ]),
                    ),
                    angle: 90,
                    positionFactor: 0.8,
                  )
                ]),
          ],
        ));
  }
}
