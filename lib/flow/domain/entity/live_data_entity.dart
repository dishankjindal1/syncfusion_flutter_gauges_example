import 'package:equatable/equatable.dart';
import 'package:pulgas_power/flow/domain/enum/live_enums.dart';

class PPLiveDataEntity extends Equatable {
  const PPLiveDataEntity({
    required this.available,
    required this.solarOuput,
    required this.pcs,
    required this.generator,
    required this.batteryVoltage,
    required this.batteryCurrent,
    required this.batteryCharge,
    required this.batterEnergy,
    required this.reportedAt,
  });

  final double available;
  final double solarOuput;
  final double pcs;
  final double generator;
  final double batteryVoltage;
  final double batteryCurrent;
  final double batteryCharge;
  final double batterEnergy;
  final String reportedAt;

  String get availableWithSymbol =>
      '$available ${LiveDataType.AVAILABLE.unitType.symbol}';
  String get solarOuputWithSymbol =>
      '$solarOuput ${LiveDataType.SOLAR_OUTPUT.unitType.symbol}';
  String get pcsWithSymbol => '$pcs ${LiveDataType.PCS.unitType.symbol}';
  String get generatorWithSymbol =>
      '$generator ${LiveDataType.GENERATOR.unitType.symbol}';
  String get batteryVoltageWithSymbol =>
      '$batteryVoltage ${LiveDataType.BATTERY_VOLTAGE.unitType.symbol}';
  String get batteryCurrentWithSymbol =>
      '$batteryCurrent ${LiveDataType.BATTERY_CURRENT.unitType.symbol}';
  String get batteryChargeWithSymbol =>
      '$batteryCharge ${LiveDataType.BATTERY_CHARGE.unitType.symbol}';
  String get batterEnergyWithSymbol =>
      '$batterEnergy ${LiveDataType.BATTERY_ENERGY.unitType.symbol}';
  String get displayReportedAt => reportedAt;

  List<(LiveDataType, double, String)> get listOfData => [
        (LiveDataType.AVAILABLE, available, availableWithSymbol),
        (LiveDataType.SOLAR_OUTPUT, solarOuput, solarOuputWithSymbol),
        (LiveDataType.PCS, pcs, pcsWithSymbol),
        (LiveDataType.GENERATOR, generator, generatorWithSymbol),
        (
          LiveDataType.BATTERY_VOLTAGE,
          batteryVoltage,
          batteryVoltageWithSymbol
        ),
        (
          LiveDataType.BATTERY_CURRENT,
          batteryCurrent,
          batteryCurrentWithSymbol
        ),
        (LiveDataType.BATTERY_CHARGE, batteryCharge, batteryChargeWithSymbol),
        (LiveDataType.BATTERY_ENERGY, batterEnergy, batterEnergyWithSymbol),
      ];

  Map<String, dynamic> toMap() => {
        'available': available,
        'solarOuput': solarOuput,
        'pcs': pcs,
        'generator': generator,
        'batteryVoltage': batteryVoltage,
        'batteryCurrent': batteryCurrent,
        'batteryCharge': batteryCharge,
        'batterEnergy': batterEnergy,
        'reportedAt': reportedAt,
      };

  @override
  List<Object?> get props => [
        available,
        solarOuput,
        pcs,
        generator,
        batteryVoltage,
        batteryCurrent,
        batteryCharge,
        batterEnergy,
        reportedAt,
      ];
}
