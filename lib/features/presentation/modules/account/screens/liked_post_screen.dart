import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/features/presentation/modules/account/account_controller.dart';

import '../../../../../core/resources/pair.dart';
import '../../../../domain/entities/posts/real_estate_post.dart';

class LikedPostScreen extends StatelessWidget {
  LikedPostScreen({super.key});

  final AccountController controller = Get.find<AccountController>();
  int page = 1;
  int totalPage = 1;
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bài đăng đã lưu"),
      ),
      body: FutureBuilder<Pair<int, List<RealEstatePostEntity>>>(
        future: controller.getPostFavorite(page),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(); // Display a loading indicator while data is being fetched
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else {
            // Update the totalPage variable based on the data received
            totalPage = snapshot.data!.first;

            return NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (scrollInfo is ScrollEndNotification &&
                    _scrollController.position.extentAfter == 0) {
                  // Reached the end of the list, load more data
                  if (page < totalPage) {
                    page++;
                    controller.getPostFavorite(page).then((newData) {
                      // Update the data in your controller or state
                      // This may vary depending on how your controller handles data
                      // For example, if your controller has a method like updateData(newData),
                      // you can call controller.updateData(newData);
                    });
                  }
                }
                return false;
              },
              child: ListView.builder(
                controller: _scrollController,
                itemCount: snapshot.data!.second.length,
                itemBuilder: (context, index) {
                  // Build your list item here using snapshot.data.second[index]
                  return ListTile(
                    title: Text(snapshot.data!.second[index].title ?? ""),
                    // Add other relevant widget properties
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
