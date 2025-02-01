import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider_student_management/db/model.dart';
import 'package:sqflite/sqflite.dart';

class StudentProvider with ChangeNotifier {
  late Database _db;
  List<StudentsModel> _students = [];
  

  List<StudentsModel> get students => _students;
   
   StudentProvider(){
    initializeDatabase();
   }

  Future<void> initializeDatabase() async{
    _db = await openDatabase(
       "student.db",
       version: 1,
       onCreate: (Database db,int version) async {
         await db.execute(
          "CREATE TABLE student (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, gender TEXT, phoneno TEXT, age TEXT, imageurl TEXT);");
       },
    );
    await getAllStudents();
  }

  Future<void> addStudent(StudentsModel student) async{
    try {
       await _db.rawInsert(
        "INSERT INTO student (name, gender, phoneno, age, imageurl) VALUES (?, ?, ?, ?, ?)",
        [student.name, student.gender, student.phoneno, student.age, student.imageurl],
      );
      _students.add(student);
      notifyListeners();
      log('Success: adding student');

    } catch (e) {
      log('Error: adding student: $e');
    }
  }

  Future<void> getAllStudents() async{
    try {
       final List<Map<String, dynamic>> studentMaps = await _db.rawQuery("SELECT * FROM student");
      _students = studentMaps.map((map) {
        return StudentsModel(
          id: map['id'],
          name: map['name'],
          gender: map['gender'],
          phoneno: map['phoneno'],
          age: map['age'],
          imageurl: map['imageurl'],
        );
      }).toList();
      notifyListeners();
    } catch (e) {
      log('Error: fetching students db $e');
    }
  }
  
  Future<void> updateStudent(StudentsModel updatedStudent) async{
    try {
         await _db.update(
        'student',
        {
          'name': updatedStudent.name,
          'gender': updatedStudent.gender,
          'phoneno': updatedStudent.phoneno,
          'age': updatedStudent.age,
          'imageurl': updatedStudent.imageurl,
        },
        where: 'id = ?',
        whereArgs: [updatedStudent.id],
      );
      _students = _students.map((student) {
        return student.id == updatedStudent.id ? updatedStudent : student;
      }).toList();
      notifyListeners();

      log('Success: Update successfull');
    } catch (e) {
      log('Error: updating student $e');
    }
  }
    
   Future<void> deleteStudent(int id) async {
    try {
      await _db.rawDelete('DELETE FROM student WHERE id = ?', [id]);
      _students.removeWhere((student) => student.id == id);
      notifyListeners();
      log('Success: delete student');

    } catch (e) {
      log("Error deleting student: $e");
    }
  }
  
}