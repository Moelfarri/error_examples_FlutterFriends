import 'dart:math';

void main() async {
  final service = ExternalService();

  final SomeResponse response = await service.fetchData();
  print("Data received: ${response.data}");
}

// External to the application calling this code
class ExternalService {
  Future<SomeResponse> fetchData() async {
    // Simulate a network call
    await Future.delayed(Duration(seconds: 1));

    Random random = Random();

    // 5% chance of failure
    if (random.nextInt(100) < 5) {
      throw Exception("Failed to fetch data");
    }

    return SomeResponse("The Data you asked for 😊");
  }
}

class SomeResponse {
  final String data;

  SomeResponse(this.data);
}
