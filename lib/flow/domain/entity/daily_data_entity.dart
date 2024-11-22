import 'package:equatable/equatable.dart';

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
  final String reportedAt;

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
  String get renewableHoursWithSymbol =>
      '${renewableHours.toStringAsFixed(2)} h.';
  String get batteryChargeWithSymbol => '$batteryCharge kWh';
  String get batteryDischargeWithSymbol => '$batteryDischarge kWh';
  String get sunHoursWithSymbol => '$sunHours h.';
  String get generatorEnergyWithSymbol => '$generatorEnergy kWh';
  String get generatorHoursWithSymbol =>
      '${generatorHours.toStringAsFixed(2)} h.';
  String get generatorFuelWithSymbol => '$generatorFuel l.';
  String get consumptionWithSymbol => '$consumption kWh';
  String get co2SavedWithSymbol => '$co2Saved TON';
  String get co2ProducedWithSymbol => '${co2Produced.toStringAsFixed(3)} TON';
  String get displayReportedAt => reportedAt;

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

  Map<String, dynamic> toMap() => <String, dynamic>{
        'spr': solarProduction,
        'rhr': renewableHours,
        'bch': batteryCharge,
        'bdc': batteryDischarge,
        'shr': sunHours,
        'gen': generatorEnergy,
        'ghr': generatorHours,
        'gfl': generatorFuel,
        'con': consumption,
        'cos': co2Saved,
        'cop': co2Produced,
        'lup': reportedAt,
      };

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
