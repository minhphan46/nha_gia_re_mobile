import 'dart:math';

import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:nhagiare_mobile/features/domain/entities/blog.dart';

class BlogController extends GetxController {
  Future<List<Blog>> getBlogs() async {
    return [
      Blog(
        id: '1',
        title: 'Tiêu đề bài viết 1',
        shortDescription: 'Mô tả ngắn gọn về bài viết 1',
        content: '<p>Nội dung bài viết 1</p>',
        thumbnail:
            'https://picsum.photos/200/300?random=${Random().nextInt(100)}',
        view: 100,
        createdAt: DateTime(2023, 1, 1),
        author: 'Tác giả 1',
        isActive: true,
      ),
      Blog(
        id: '2',
        title: 'Tiêu đề bài viết 2',
        shortDescription: 'Mô tả ngắn gọn về bài viết 2',
        content: '<p>Nội dung bài viết 2</p>',
        thumbnail:
            'https://picsum.photos/200/300?random=${Random().nextInt(100)}',
        view: 150,
        createdAt: DateTime(2023, 1, 2),
        author: 'Tác giả 2',
        isActive: true,
      ),
      Blog(
        id: '3',
        title: 'Tiêu đề bài viết 3',
        shortDescription: 'Mô tả ngắn gọn về bài viết 3',
        content: '<p>Nội dung bài viết 3</p>',
        thumbnail:
            'https://picsum.photos/200/300?random=${Random().nextInt(100)}',
        view: 200,
        createdAt: DateTime(2023, 1, 3),
        author: 'Tác giả 3',
        isActive: false,
      ),
    ];
  }
}
