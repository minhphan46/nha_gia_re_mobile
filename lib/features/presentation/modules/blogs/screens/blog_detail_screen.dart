import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:nhagiare_mobile/core/extensions/date_ex.dart';
import 'package:nhagiare_mobile/features/domain/entities/blog.dart';
import 'package:nhagiare_mobile/features/presentation/modules/blogs/blog_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

class BlogDetailScreen extends StatelessWidget {
  final BlogController controller = Get.put(BlogController());
  BlogDetailScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    BlogEntity blog = Get.arguments;
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blog.title,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  blog.shortDescription,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      blog.author,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Icon(Icons.watch_later_outlined),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(blog.createdAt.getTimeAgo())
                  ],
                ),
                FutureBuilder(
                  future: Future.delayed(Duration.zero),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Html(
                        data: blog.content,
                        onLinkTap: (url, attributes, element) async {
                          await launchUrl(
                            Uri.parse(url!),
                            mode: LaunchMode.externalApplication,
                          );
                        },
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                )
              ],
            ),
          ),
        ));
  }
}
