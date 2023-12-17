import 'dart:io';

import '../../../core/resources/data_state.dart';

abstract class MediaRepository {
  Future<DataState<List<String>>> uploadMedia(List<File> media);
}
