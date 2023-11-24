import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;

void main() {
  // Số lượng người dùng đồng thời cần kiểm tra
  final int numberOfUsers = 10;

  // Địa chỉ của trang web cần kiểm tra
  final String url = 'https://student.uit.edu.vn/';

  // Hàm thực hiện yêu cầu HTTP và in kết quả
  Future<void> fetchUrl(int index) async {
    // Calculate time
    final stopwatch = Stopwatch()..start();
    final response = await http.get(Uri.parse(url));
    stopwatch.stop();
    print(
        'User $index - Status code: ${response.statusCode} - Elapsed time: ${stopwatch.elapsedMilliseconds}ms');
  }

  // Tạo danh sách các công việc (đồng thời)
  final List<Future<void>> tasks = [];

  // Bắt đầu đồng thời kiểm tra
  for (int i = 1; i <= 1; i++) {
    tasks.add(fetchUrl(i));
  }

  // Chờ tất cả các công việc hoàn thành
  Future.wait(tasks).then((_) {
    print('All users have completed the request.');
    exit(0); // Kết thúc chương trình
  });
}
