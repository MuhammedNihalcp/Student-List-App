import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stutent_list/db/model/data_model.dart';

ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);

void addStudent(StudentModel value) async {
  var dir = await getApplicationDocumentsDirectory();
  Hive.initFlutter(dir.path);
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  final int _id = await studentDB.add(value);
  value.id = _id;
  studentListNotifier.value.add(value);
  studentListNotifier.notifyListeners();
}

Future<void> getAllStudent() async {
  var dir = await getApplicationDocumentsDirectory();
  Hive.initFlutter(dir.path);
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  studentListNotifier.value.clear();
  studentListNotifier.value.addAll(studentDB.values);
  studentListNotifier.notifyListeners();
}

Future<void> updateStudent(int id, StudentModel value) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  studentDB.putAt(id, value);
}

Future<void> deleteStudent(int index) async {
  var dir = await getApplicationDocumentsDirectory();
  Hive.initFlutter(dir.path);
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  await studentDB.deleteAt(index);
  getAllStudent();
}
