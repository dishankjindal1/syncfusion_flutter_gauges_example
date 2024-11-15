import 'package:flutter/material.dart';
import 'package:pulgas_power/core/theme/theme.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class InfoLinear extends StatelessWidget {
  const InfoLinear({
    required this.data,
    super.key,
  });

  final List<(double, String)> data;

  @override
  Widget build(BuildContext context) {
    const double trackThickness = 30;
    return SfLinearGauge(
      minimum: 0,
      maximum: 24,
      maximumLabels: 0,
      minorTickStyle: const LinearTickStyle(
        length: 0,
        thickness: 0,
      ),
      majorTickStyle: const LinearTickStyle(
        length: 0,
        thickness: 0,
      ),
      showAxisTrack: false,
      ranges: const [
        LinearGaugeRange(
          startValue: 0,
          endValue: 5,
          startWidth: trackThickness,
          endWidth: trackThickness,
          color: Colors.red,
        ),
        LinearGaugeRange(
          startValue: 5,
          endValue: 8.5,
          startWidth: trackThickness,
          endWidth: trackThickness,
          color: Colors.yellow,
        ),
        LinearGaugeRange(
          startValue: 8.5,
          endValue: 20,
          startWidth: trackThickness,
          endWidth: trackThickness,
          color: Colors.green,
        ),
        LinearGaugeRange(
          startValue: 20,
          endValue: 24,
          startWidth: trackThickness,
          endWidth: trackThickness,
          color: Color(PPTheme.greyColor),
        ),
      ],
      markerPointers: [
        for (final (double value, String msg) in data)
          LinearWidgetPointer(
            value: value,
            position: LinearElementPosition.outside,
            offset: 30,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                const Icon(
                  Icons.location_on,
                  color: Colors.black,
                  size: 36,
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    msg,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
