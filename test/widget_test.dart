import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;

Future<void> main() async {
  const url = 'https://198.252.101.180/';
  const numberOfRequests = 1000000; // Số lượng request bạn muốn thử nghiệm

  // Tạo một danh sách các Future để theo dõi các request đồng thời
  final List<Future<void>> futures = [];

  for (int i = 0; i < numberOfRequests; i++) {
    futures.add(sendRequest(url, i + 1));
  }

  // Chạy tất cả các request đồng thời và đợi chúng hoàn thành
  print('Sending $numberOfRequests requests...');
  await Future.wait(futures);
}

Future<void> sendRequest(String url, int requestNumber) async {
  try {
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == HttpStatus.ok) {
      print('Request $requestNumber successful');
    } else {
      print(
          'Request $requestNumber failed with status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Request $requestNumber failed with error: $e');
  }
}
