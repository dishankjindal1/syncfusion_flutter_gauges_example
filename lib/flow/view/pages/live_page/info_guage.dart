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
    const double gaugeWidth = 24;

    return SizedBox.square(
      dimension: 240,
      child: Container(
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
                  maximumLabels: type.rangeType.isNoColor ? 5 : 3,
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
                      needleLength: type.isBatterEnergy
                          ? 0.7
                          : type.startRange.isNegative
                              ? 0.715
                              : 0.73,
                      value: value,
                      needleEndWidth: 4,
                    ),
                  ],
                  annotations: [
                    GaugeAnnotation(
                      widget: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                type.unitType.label,
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                valueWithSymbol,
                                style: const TextStyle(
                                  fontSize: 20,
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
          )),
    );
  }
}
