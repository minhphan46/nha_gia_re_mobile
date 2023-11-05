import 'package:equatable/equatable.dart';

class Blog extends Equatable {
  final String id;
  final String title;
  final String shortDescription;
  final String author;
  final String content;
  final String thumbnail;
  final int view;
  final DateTime createdAt;
  final bool isActive;

  const Blog({
    required this.id,
    required this.title,
    required this.shortDescription,
    required this.content,
    required this.thumbnail,
    required this.view,
    required this.createdAt,
    required this.author,
    required this.isActive,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        shortDescription,
        content,
        thumbnail,
        view,
        createdAt,
        author,
        isActive,
      ];
}
