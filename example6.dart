import 'dart:math';
import 'either_freezed.dart';

void main() async {
  final service = MyBLEGatewayService();

  final Either<BLEDeviceInformation, MyBLEGatewayException> either =
      await service.getDeviceInformation();

  either.when(
    success: (value) {
      print("Data received: ${value}");
    },
    failure: (error) {
      print("Error occurred: ${error}");
    },
  );
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

      return Either.success(
        BLEDeviceInformation(
          deviceName: response['informationService']['deviceName'],
          deviceId: response['informationService']['deviceId'],
        ),
      );
    } catch (e) {
      switch (e) {
        case final DeviceNotConnectedException e:
          return Either.failure(e);
        case final DeviceInformationNotFoundException e:
          return Either.failure(e);
        default:
          return Either.failure(UnexpectedBLEGatewayException(e.toString()));
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
