import 'package:flutter/material.dart';

import '../../../core/constant.dart';
import '../../add_student/widget/custom_text.dart';
import '../../add_student/widget/validation.dart';
import '../detailpage.dart';

class EditTextFiled extends StatelessWidget {
  const EditTextFiled({
    super.key,
    required this.widget,
    required this.nameController,
    required bool isEditing,
    required this.ageController,
    required this.phoneController,
  }) : _isEditing = isEditing;

  final Detailpage widget;
  final TextEditingController nameController;
  final bool _isEditing;
  final TextEditingController ageController;
  final TextEditingController phoneController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
          hight10,
        CustomTextFormFild(
          icon: Icons.person,
          labelText: 'Name',
          hintText: widget.studentDetails.name,
          controller: nameController,
          validate: NameValidator.validate,
          enabled: _isEditing,
        ),
         PhoneNumberFiled(
      icon: Icons.cake_sharp,
      labelText: 'Age',
      hintText: widget.studentDetails.age,
      controller: ageController,
      validate: AgeValidator.validate,
      enable: _isEditing,
    ),
     PhoneNumberFiled(
      icon: Icons.phone,
      labelText: 'Phone Number',
      hintText: widget.studentDetails.phoneno,
      controller: phoneController,
      validate: PhoneNumberValidator.validate,
      enable: _isEditing,
    ),hight10, Text('     Select Gender'),
      ],
    );
  }
}
