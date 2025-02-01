import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DetailsEditProvider  with ChangeNotifier {
  File? _selectedImage;
   String? _selectedGender;

  File? get selectedImage => _selectedImage;
  String? get selectedGender => _selectedGender;


 

  void initializeStudent(String imageUrl, String gender) {
  _selectedImage =  imageUrl.isNotEmpty ? File(imageUrl) : null;
  _selectedGender = gender;
  notifyListeners();
}


  Future<void> pickImageFromGallery() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      _selectedImage = File(pickedImage.path);
      notifyListeners();
    }
  }

  
  void updateSelectedGender(String gender){
    if(_selectedGender != gender){
       
    _selectedGender = gender;
    notifyListeners();
    } 
  }
    void resetSelection({required updatedimage, required updatedGender}) {
       _selectedImage = updatedimage.isNotEmpty ? File(updatedimage) : _selectedImage;
        _selectedGender = updatedGender;
    notifyListeners();
 }
}
