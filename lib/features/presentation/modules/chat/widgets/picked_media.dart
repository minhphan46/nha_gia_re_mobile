import 'dart:io';
import 'package:flutter/material.dart';

class PickedMedia extends StatelessWidget {
  final File file;
  final Function(File)? onRemove;
  const PickedMedia({super.key, required this.file, this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(right: 5),
          height: 100,
          width: 100,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.file(
              file,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              icon: const Icon(Icons.close),
              color: Colors.white,
              onPressed: () {
                onRemove?.call(file);
              },
              splashRadius: 14,
              padding: EdgeInsets.zero,
            ),
          ),
        ),
      ],
    );
  }
}
