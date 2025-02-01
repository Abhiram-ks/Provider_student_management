import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class StudentFormProvider with ChangeNotifier{
  File? _selectedImage;
  String _selectedGender = 'O';

  File? get selectedImage => _selectedImage;
  String get selectedGender => _selectedGender;

  void changeGender(String? newGender){
    _selectedGender = newGender ?? 'O';
    notifyListeners();
  }

  Future<void> pickImageFromGallery() async{
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

    if(pickedImage != null){
      _selectedImage = File(pickedImage.path);
      notifyListeners();
    }
  }

  void clearForm(){
    _selectedImage = null;
    _selectedGender = 'O';
    notifyListeners();
  }
}

