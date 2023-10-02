import 'dart:io';

import 'package:dio/dio.dart';
import 'package:nhagiare_mobile/core/resources/data_state.dart';
import 'package:nhagiare_mobile/features/data/data_sources/local/app_database.dart';
import 'package:nhagiare_mobile/features/data/data_sources/remote/new_api_service.dart';
import 'package:nhagiare_mobile/features/data/models/task.dart';
import 'package:nhagiare_mobile/features/data/models/task_local.dart';
import 'package:nhagiare_mobile/features/domain/entities/task.dart';
import 'package:nhagiare_mobile/features/domain/repository/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final NewApiService _newApiService;
  final AppDatabase _appDatabase;
  TaskRepositoryImpl(this._newApiService, this._appDatabase);

  @override
  Future<DataState<List<TaskModel>>> getTasks() async {
    try {
      final httpResponse = await _newApiService.getTasks();

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioException(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
          requestOptions: httpResponse.response.requestOptions,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<TaskModel>> getTask(String id) async {
    try {
      final httpResponse = await _newApiService.getSingleTask(id);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioException(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
          requestOptions: httpResponse.response.requestOptions,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<TaskModel>> createTask(TaskEntity task) async {
    try {
      final httpResponse =
          await _newApiService.createTask(TaskModel.fromEntity(task));

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioException(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
          requestOptions: httpResponse.response.requestOptions,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<TaskModel>> deleteTask(String id) async {
    try {
      final httpResponse = await _newApiService.deleteTask(id);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return const DataSuccess(null);
      } else {
        return DataFailed(DioException(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
          requestOptions: httpResponse.response.requestOptions,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<TaskModel>> updateTask(TaskEntity task) async {
    try {
      final httpResponse =
          await _newApiService.updateTask(task.id!, TaskModel.fromEntity(task));

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioException(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
          requestOptions: httpResponse.response.requestOptions,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  //  local
  @override
  Future<List<TaskModel>> getTasksLocal() async {
    return _appDatabase.taskDao
        .getTasks()
        .then((value) => value.map((e) => TaskModel.fromLocal(e)).toList());
  }

  @override
  Future<void> removeTaskLocal(TaskEntity task) {
    return _appDatabase.taskDao
        .deleteTask(TaskLocalModel.fromLocal(TaskModel.fromEntity(task)));
  }

  @override
  Future<void> saveTaskLocal(TaskEntity task) {
    return _appDatabase.taskDao
        .insertTask(TaskLocalModel.fromLocal(TaskModel.fromEntity(task)));
  }
}
