import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class FileExt {
  const FileExt._();

  static const List<String> allowedImageFormats = [
    'jpg',
    'jpeg',
    'png',
    'gif',
    'svg+xml',
    'webp',
    'avif'
  ];

  static String getFileFormat(String fileName) {
    return fileName.split('.').last;
  }

  static String getFileType(String fileName) {
    String fileFormat = getFileFormat(fileName);
    if (allowedImageFormats.contains(fileFormat)) {
      return FileType.image;
    }
    return FileType.file;
  }

  static Future<File> bytesArray2File(
      Uint8List bytesArray, String filename) async {
    final tempDir = await getTemporaryDirectory();
    File file = await File('${tempDir.path}/$filename').create();
    file.writeAsBytesSync(bytesArray);
    return file;
  }
}

class FileType {
  static const String image = 'image';
  static const String file = 'files';
}
