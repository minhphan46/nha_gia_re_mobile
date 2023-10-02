import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:floor/floor.dart';
import '../../models/task_local.dart';
import 'DAO/task_dao.dart';
part 'app_database.g.dart';

@Database(version: 1, entities: [TaskLocalModel])
abstract class AppDatabase extends FloorDatabase {
  TaskDao get taskDao;
}
