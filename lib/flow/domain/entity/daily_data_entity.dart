import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class PPDailyDataEntity extends Equatable {
  final double solarProduction;
  final double renewableHours;
  final double batteryCharge;
  final double batteryDischarge;
  final double sunHours;
  final double generatorEnergy;
  final double generatorHours;
  final double generatorFuel;
  final double consumption;
  final double co2Saved;
  final double co2Produced;
  final DateTime reportedAt;

  const PPDailyDataEntity({
    required this.solarProduction,
    required this.renewableHours,
    required this.batteryCharge,
    required this.batteryDischarge,
    required this.sunHours,
    required this.generatorEnergy,
    required this.generatorHours,
    required this.generatorFuel,
    required this.consumption,
    required this.co2Saved,
    required this.co2Produced,
    required this.reportedAt,
  });

  String get solarProductionWithSymbol => '$solarProduction kWh';
  String get renewableHoursWithSymbol => '$renewableHours h.';
  String get batteryChargeWithSymbol => '$batteryCharge kWh';
  String get batteryDischargeWithSymbol => '$batteryDischarge kWh';
  String get sunHoursWithSymbol => '$sunHours h.';
  String get generatorEnergyWithSymbol => '$generatorEnergy kWh';
  String get generatorHoursWithSymbol => '$generatorHours h.';
  String get generatorFuelWithSymbol => '$generatorFuel l.';
  String get consumptionWithSymbol => '$consumption kWh';
  String get co2SavedWithSymbol => '$co2Saved TON';
  String get co2ProducedWithSymbol => '${co2Produced.toStringAsFixed(3)} TON';
  String get displayReportedAt => DateFormat('dd MMM yyyy').format(reportedAt);

  List<(String, String)> get listOfData => [
        ('Solar Production', solarProductionWithSymbol),
        ('Renewable Hours', renewableHoursWithSymbol),
        ('Battery Charge', batteryChargeWithSymbol),
        ('Battery Discharge', batteryDischargeWithSymbol),
        ('Sun Hours', sunHoursWithSymbol),
        ('Generator Energy', generatorEnergyWithSymbol),
        ('Generator Hours', generatorHoursWithSymbol),
        ('Generator Fuel', generatorFuelWithSymbol),
        ('Consumption', consumptionWithSymbol),
        ('CO2 Saved', co2SavedWithSymbol),
        ('CO2 Produced', co2ProducedWithSymbol),
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'solarProduction': solarProduction,
      'renewableHours': renewableHours,
      'batteryCharge': batteryCharge,
      'batteryDischarge': batteryDischarge,
      'sunHours': sunHours,
      'generatorEnergy': generatorEnergy,
      'generatorHours': generatorHours,
      'generatorFuel': generatorFuel,
      'consumption': consumption,
      'co2Saved': co2Saved,
      'co2Produced': co2Produced,
      'reportedAt': reportedAt.millisecondsSinceEpoch,
    };
  }

  @override
  List<Object?> get props => [
        solarProduction,
        renewableHours,
        batteryCharge,
        batteryDischarge,
        sunHours,
        generatorEnergy,
        generatorHours,
        generatorFuel,
        consumption,
        co2Saved,
        co2Produced,
        reportedAt,
      ];
}

class PPDailyDataModel extends PPDailyDataEntity {
  const PPDailyDataModel({
    required super.solarProduction,
    required super.renewableHours,
    required super.batteryCharge,
    required super.batteryDischarge,
    required super.sunHours,
    required super.generatorEnergy,
    required super.generatorHours,
    required super.generatorFuel,
    required super.consumption,
    required super.co2Saved,
    required super.co2Produced,
    required super.reportedAt,
  });

  factory PPDailyDataModel.fromMap(Map<String, dynamic> map) =>
      PPDailyDataModel(
        solarProduction: map['solarProduction'] as double,
        renewableHours: map['renewableHours'] as double,
        batteryCharge: map['batteryCharge'] as double,
        batteryDischarge: map['batteryDischarge'] as double,
        sunHours: map['sunHours'] as double,
        generatorEnergy: map['generatorEnergy'] as double,
        generatorHours: map['generatorHours'] as double,
        generatorFuel: map['generatorFuel'] as double,
        consumption: map['consumption'] as double,
        co2Saved: map['co2Saved'] as double,
        co2Produced: map['co2Produced'] as double,
        reportedAt:
            DateTime.fromMillisecondsSinceEpoch(map['reportedAt'] as int),
      );
}
