import 'dart:math';
import 'either_full_implementation.dart';

void main() async {
  final service = MyBLEGatewayService();

  final Either<BLEDeviceInformation, MyBLEGatewayException> either =
      await service.getDeviceInformation();

  final _ = either.doOnFailure(
    (error) {
      reportErrorToServer('oh shit!');
    },
  ).successOrNull();
}

void reportErrorToServer(String error) {
  // Simulate sending error to a server
  print("Reporting error to server: $error");
}

// my service abstraction
class MyBLEGatewayService {
  Future<Either<BLEDeviceInformation, MyBLEGatewayException>>
  getDeviceInformation() async {
    try {
      final nativeService = SomeNativeBluetoothLowEnergyService();
      if (!nativeService.isBLEDeviceConnected)
        throw DeviceNotConnectedException();

      final Map<String, dynamic> response = await nativeService
          .discoverServices();

      if (response['informationService'] == null ||
          response['informationService']['deviceName'] == null ||
          response['informationService']['deviceId'] == null) {
        throw DeviceInformationNotFoundException();
      }

      return Success(
        BLEDeviceInformation(
          deviceName: response['informationService']['deviceName'],
          deviceId: response['informationService']['deviceId'],
        ),
      );
    } catch (e) {
      switch (e) {
        case final DeviceNotConnectedException e:
          return Failure(e);
        case final DeviceInformationNotFoundException e:
          return Failure(e);
        default:
          return Failure(UnexpectedBLEGatewayException(e.toString()));
      }
    }
  }
}

/// BLE Gateway Response Class
class BLEDeviceInformation {
  BLEDeviceInformation({
    required this.deviceName,
    required this.deviceId,
    this.characteristics,
  });

  final String deviceName;
  final String deviceId;
  final Object? characteristics;
}

/// Exceptions
abstract class MyBLEGatewayException implements Exception {
  final String message;

  MyBLEGatewayException(this.message);

  @override
  String toString() => 'MyBLEGatewayException: $message';
}

class UnexpectedBLEGatewayException extends MyBLEGatewayException {
  UnexpectedBLEGatewayException(String message) : super(message);
}

class DeviceNotConnectedException extends MyBLEGatewayException {
  DeviceNotConnectedException() : super('Device not found.');
}

class DeviceInformationNotFoundException extends MyBLEGatewayException {
  DeviceInformationNotFoundException() : super('Device information not found.');
}

// EXTERNAL API EXAMPLE
class SomeNativeBluetoothLowEnergyService {
  final bool isBLEDeviceConnected = true; // Simulating a connected device

  final Map<String, dynamic> data = {
    'informationService': {
      'deviceName': 'Native Device',
      'deviceId': '67890',
    },
    'SomeOtherData': {
      'status': 'active',
      'batteryLevel': 85,
    },
  };

  Future<Map<String, dynamic>> discoverServices() async {
    Random random = Random();

    // 50% chance of failure
    if (random.nextInt(100) < 50) {
      throw Exception("Failed to fetch data");
    }

    return data;
  }
}
