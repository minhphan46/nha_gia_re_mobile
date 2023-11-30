import 'package:nhagiare_mobile/features/data/models/tasks/task_local.dart';
import 'package:nhagiare_mobile/features/domain/entities/task/task.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

//ignore: must_be_immutable
class TaskModel extends TaskEntity {
  const TaskModel({
    super.id,
    super.title,
    super.date,
    super.done,
    super.color,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['_id'] ?? DateTime.now().toString(),
      title: json['title'] ?? "",
      done: json['done'] ?? false,
      date: DateTime.tryParse(json['createdAt']) ?? DateTime.now(),
      color: json['color'] ??
          Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
              .withOpacity(1.0),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'done': done,
    };
  }

  factory TaskModel.fromEntity(TaskEntity entity) {
    return TaskModel(
      id: entity.id,
      title: entity.title,
      done: entity.done,
      date: entity.date,
      color: entity.color,
    );
  }

  factory TaskModel.fromLocal(TaskLocalModel localModel) {
    return TaskModel(
      id: localModel.id,
      title: localModel.title,
      done: localModel.done,
      date: DateTime.fromMillisecondsSinceEpoch(localModel.date!),
      color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
          .withOpacity(1.0),
    );
  }
}
