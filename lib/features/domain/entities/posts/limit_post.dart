import 'package:equatable/equatable.dart';

class LitmitPostEntity extends Equatable {
  final bool? isExceeded;
  final int? limitPostInMonth;
  final int? countPostInMonth;

  const LitmitPostEntity({
    this.isExceeded,
    this.limitPostInMonth,
    this.countPostInMonth,
  });

  @override
  List<Object?> get props => [
        isExceeded,
        limitPostInMonth,
        countPostInMonth,
      ];

  factory LitmitPostEntity.fromJson(Map<String, dynamic> json) =>
      LitmitPostEntity(
        isExceeded: json['isExceeded'] as bool?,
        limitPostInMonth: json['limit_post_in_month'] as int?,
        countPostInMonth: json['count_post_in_month'] as int?,
      );

  LitmitPostEntity copyWith({
    bool? isExceeded,
    int? limitPostInMonth,
    int? countPostInMonth,
  }) {
    return LitmitPostEntity(
      isExceeded: isExceeded ?? this.isExceeded,
      limitPostInMonth: limitPostInMonth ?? this.limitPostInMonth,
      countPostInMonth: countPostInMonth ?? this.countPostInMonth,
    );
  }
}
