import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nhagiare_mobile/features/presentation/modules/chat/widgets/picked_media.dart';

class MediaRow extends StatelessWidget {
  final List<File> media;
  final Function(File)? onRemove;
  final Function()? onClear;
  const MediaRow({super.key, required this.media, this.onRemove, this.onClear});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...media.map((media) {
            return PickedMedia(
              file: media,
              onRemove: onRemove,
            );
          }),
          SizedBox(
            height: 100,
            width: 100,
            child: Center(
              child: TextButton(
                onPressed: onClear,
                // onPressed: _controller.mediaPicker.clear,
                child: const Text("Xoá tất cả"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
