import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pulgas_power/flow/domain/entity/live_data_entity.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class PPInfoGuage extends StatelessWidget {
  const PPInfoGuage({
    required this.data,
    super.key,
  });

  final PPLiveDataEntity data;

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
              text: data.type.chartTitle,
            ),
            axes: [
              RadialAxis(
                  canRotateLabels: true,
                  minimum: data.type.startRange.toDouble(),
                  maximum: data.type.endRange.toDouble(),
                  maximumLabels: data.type.rangeType.isNoColor ? 5 : 3,
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
                    if (data.type.rangeType.isNoColor)
                      GaugeRange(
                        startValue: data.type.startRange.toDouble(),
                        endValue: data.type.endRange.toDouble(),
                        startWidth: gaugeWidth,
                        endWidth: gaugeWidth,
                        color: Colors.white,
                      )
                    else ...[
                      if (data.type.rangeType.isMultiColor)
                        for (final range in data.type.ranges!)
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
                          endValue: data.value.toDouble(),
                          startWidth: gaugeWidth,
                          endWidth: gaugeWidth,
                          color: Colors.green,
                        ),

                      /// Add the black pointer on the guage strip
                      if (data.stickyPoint != null)
                        GaugeRange(
                          startValue: data.stickyPoint!.toDouble() -
                              (data.type.stickyTickerSize! ~/ 2),
                          endValue: data.stickyPoint!.toDouble() +
                              (data.type.stickyTickerSize! ~/ 2),
                          startWidth: gaugeWidth,
                          endWidth: gaugeWidth,
                          color: Colors.black54,
                        )
                    ],
                  ],
                  pointers: [
                    NeedlePointer(
                      enableAnimation: true,
                      needleLength: data.type.isBatterEnergy
                          ? 0.7
                          : data.type.startRange.isNegative
                              ? 0.715
                              : 0.73,
                      value: data.value.toDouble(),
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
                                data.type.unitType.label,
                                style: const TextStyle(
                                  fontSize: 24,
                                ),
                              ),
                              Text(
                                data.valueWithSymbol,
                                style: const TextStyle(
                                  fontSize: 24,
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
