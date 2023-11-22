import 'package:socket_io_client/socket_io_client.dart' as IO;

void main() {
  print("Hello World");
  IO.Socket socket =
      IO.io('http://localhost:8000/conversations', <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': false,
    'conversation_id': '28223664-4747-424e-b2e3-27ace26bc553'
  });
  socket.id = "28223664-4747-424e-b2e3-27ace26bc553";
  socket.auth = {"token": "28223664-4747-424e-b2e3-27ace26bc553"};
  socket.onConnect((data) {
    print('Connected');
  });
  socket.on('conversations', (data) {
    print(data);
  });

  socket.onDisconnect((_) {
    print('Disconnected');
  });

  socket.onError((error) {
    print('Error: $error');
  });

  // Thêm event onConnectError để bắt sự kiện lỗi khi kết nối không thành công.
  socket.onConnectError((error) {
    print('Connection error: $error');
  });
  socket.emit('GetConversations', '28223664-4747-424e-b2e3-27ace26bc553');
  // Kết nối tới server
  socket.connect();
}
