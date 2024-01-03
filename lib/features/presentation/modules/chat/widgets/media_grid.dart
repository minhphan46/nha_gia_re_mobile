import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MediaGrid extends StatelessWidget {
  final List<String> medias;
  final Function(int index)? onMediaTap;

  const MediaGrid(this.medias, {super.key, this.onMediaTap});

  @override
  Widget build(BuildContext context) {
    int column;
    if (medias.length == 1) {
      column = 1;
    } else if (medias.length == 2 || medias.length == 4) {
      column = 2;
    } else {
      column = 3;
    }
    return GridView.builder(
      shrinkWrap: true,
      // Add shrinkWrap property
      physics: const NeverScrollableScrollPhysics(),
      // Add physics property
      itemCount: medias.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: column,
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 5.0,
      ),
      itemBuilder: (BuildContext context, int index) {
        return ClipRRect(
          key: Key(medias[index]),
          borderRadius: BorderRadius.circular(5),
          child: InkWell(
            onTap: onMediaTap != null ? () => onMediaTap!(index) : null,
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              progressIndicatorBuilder: (context, url, progress) => Center(
                child: CircularProgressIndicator(
                  value: progress.progress,
                ),
              ),
              imageUrl: medias[index],
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        );
      },
    );
  }
}
