import 'dart:math';

void main() async {
  final service = SomeNativeBluetoothLowEnergyService();

  final Map<String, dynamic> response = await service.discoverServices();
  print("Data received: ${response}");
}

class SomeNativeBluetoothLowEnergyService {
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
