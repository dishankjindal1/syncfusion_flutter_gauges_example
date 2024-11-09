import 'package:flutter/material.dart';

enum OutputRangeType {
  RANGE_MOVES_WITH_POINTER,
  RANGE_WITH_MULTIPLE_COLORS,
  RANGE_WITH_NO_COLOR;

  bool get isNoColor => this == RANGE_WITH_NO_COLOR;
  bool get isMultiColor => this == RANGE_WITH_MULTIPLE_COLORS;
}

enum OutputUnitType {
  KW('kW', 'Power'),
  KWH('kWh', 'Power'),
  A('A', 'Current'),
  V('V', 'Voltage');

  const OutputUnitType(this.symbol, this.label);

  final String symbol;
  final String label;
}

enum LiveDataType {
  AVAILABLE(
    'Available',
    OutputUnitType.KW,
    0,
    650,
    OutputRangeType.RANGE_MOVES_WITH_POINTER,
    null,
    null,
  ),
  SOLAR_OUTPUT(
    'Solar Output',
    OutputUnitType.KW,
    0,
    650,
    OutputRangeType.RANGE_MOVES_WITH_POINTER,
    null,
    null,
  ),
  PCS(
    'PCS',
    OutputUnitType.KW,
    0,
    400,
    OutputRangeType.RANGE_MOVES_WITH_POINTER,
    null,
    null,
  ),
  GENERATOR(
    'Generator',
    OutputUnitType.KW,
    0,
    400,
    OutputRangeType.RANGE_MOVES_WITH_POINTER,
    null,
    null,
  ),
  BATTERY_VOLTAGE(
    'Battery Voltage',
    OutputUnitType.V,
    380,
    600,
    OutputRangeType.RANGE_WITH_MULTIPLE_COLORS,
    [
      (380, 408, Colors.red),
      (408, 425, Colors.yellow),
      (425, 560, Colors.green),
      (560, 583, Colors.yellow),
      (583, 600, Colors.red),
    ],
    2,
  ),
  BATTERY_CURRENT(
    'Battery Current',
    OutputUnitType.A,
    -600,
    600,
    OutputRangeType.RANGE_WITH_MULTIPLE_COLORS,
    [
      (-600, -550, Colors.yellow),
      (-550, 550, Colors.green),
      (550, 600, Colors.yellow),
    ],
    10,
  ),
  BATTERY_CHARGE(
    'Battery Charge',
    OutputUnitType.A,
    -350,
    350,
    OutputRangeType.RANGE_WITH_MULTIPLE_COLORS,
    [
      (-350, -325, Colors.yellow),
      (-325, 325, Colors.green),
      (325, 350, Colors.yellow),
    ],
    6,
  ),
  BATTERY_ENERGY(
    'Battery Energy',
    OutputUnitType.KWH,
    0,
    2000,
    OutputRangeType.RANGE_WITH_NO_COLOR,
    null,
    10,
  );

  factory LiveDataType.fromString(final String value) {
    return switch (value) {
      'AVAILABLE' => AVAILABLE,
      'SOLAR_OUTPUT' => SOLAR_OUTPUT,
      'PCS' => PCS,
      'GENERATOR' => GENERATOR,
      'BATTERY_VOLTAGE' => BATTERY_VOLTAGE,
      'BATTERY_CURRENT' => BATTERY_CURRENT,
      'BATTERY_CHARGE' => BATTERY_CHARGE,
      'BATTERY_ENERGY' => BATTERY_ENERGY,
      _ => AVAILABLE,
    };
  }

  const LiveDataType(
    this.chartTitle,
    this.unitType,
    this.startRange,
    this.endRange,
    this.rangeType,
    this.ranges,
    this.stickyTickerSize,
  )   : assert(startRange < endRange),
        assert(rangeType == OutputRangeType.RANGE_WITH_MULTIPLE_COLORS
            ? ranges != null
            : true);

  final String chartTitle;
  final OutputUnitType unitType;
  final int startRange;
  final int endRange;
  final OutputRangeType rangeType;
  final List<(int, int, Color)>? ranges;
  final int? stickyTickerSize;

  bool get isBatterEnergy => this == LiveDataType.BATTERY_ENERGY;
}
