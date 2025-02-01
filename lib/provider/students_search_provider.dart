import 'package:flutter/material.dart';
import 'package:provider_student_management/db/model.dart';
import 'package:provider_student_management/db/provider_db_helper.dart';

class StudentsSearchProvider with ChangeNotifier {
  final StudentProvider _studentProvider;
  List<StudentsModel>  _filteredStudents = [];


  StudentsSearchProvider(this._studentProvider){
    _filteredStudents = _studentProvider.students;
  }

  List<StudentsModel> get filteredStudents  => _filteredStudents;

  void searchStudents(String searchTerm){
    if (searchTerm.isEmpty) {
      _filteredStudents = _studentProvider.students;
    } else {
        _filteredStudents = _studentProvider.students
          .where((student) =>
              student.name.toLowerCase().contains(searchTerm.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
  
  Future<void> fetchStudents() async{
    await _studentProvider.getAllStudents();
    _filteredStudents = _studentProvider.students;
    notifyListeners();
  }
}