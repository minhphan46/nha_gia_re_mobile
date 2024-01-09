import 'package:equatable/equatable.dart';
import 'package:nhagiare_mobile/features/domain/enums/report_enums.dart';

class ReportEntity extends Equatable {
  final String? reportedId;
  final ReportContentType? contentType;
  final String? description;
  final ReportType? type;
  final List<String>? images;

  const ReportEntity({
    this.reportedId,
    this.contentType,
    this.description,
    this.type,
    this.images,
  });

  @override
  List<Object?> get props => [
        reportedId,
        contentType,
        description,
        type,
        images,
      ];

  ReportEntity copyWith({
    String? reportedId,
    ReportContentType? contentType,
    String? description,
    ReportType? type,
    List<String>? images,
  }) {
    return ReportEntity(
      reportedId: reportedId ?? this.reportedId,
      contentType: contentType ?? this.contentType,
      description: description ?? this.description,
      type: type ?? this.type,
      images: images ?? this.images,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reported_id': reportedId,
      'content_type': contentType?.toString(),
      'description': description,
      'type': type?.toString(),
      'images': images,
    };
  }
}
