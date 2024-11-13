import 'package:flutter/material.dart';
import 'package:pulgas_power/core/theme/theme.dart';
import 'package:super_tooltip/super_tooltip.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class InfoLinear extends StatelessWidget {
  const InfoLinear({
    required this.data,
    super.key,
  });

  final List<(double, String, SuperTooltipController)> data;

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
        for (final (double value, String msg, SuperTooltipController ctrl)
            in data)
          LinearWidgetPointer(
            value: value,
            position: LinearElementPosition.outside,
            offset: 30,
            child: SuperTooltip(
              controller: ctrl,
              verticalOffset: -4,
              hasShadow: false,
              showBarrier: false,
              popupDirection: TooltipDirection.up,
              minimumOutsideMargin: 0,
              borderRadius: 4,
              arrowLength: 10,
              arrowBaseWidth: 10,
              bubbleDimensions:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              content: Text(
                msg,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.black,
              child: const SizedBox.shrink(),
            ),
            onAnimationCompleted: () {
              ctrl.showTooltip();
            },
          ),
      ],
    );
  }
}
