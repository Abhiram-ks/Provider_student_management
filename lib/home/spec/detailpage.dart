import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:provider_student_management/home/spec/widget/edit_textfiled.dart';
import '../../core/colors/colors.dart';
import '../../core/constant.dart';
import '../../db/model.dart';
import '../../db/provider_db_helper.dart';
import '../../provider/details_edit_provider.dart';
import '../add_student/widget/gender_selection.dart';
import '../widget/appbar.dart';
import '../widget/bottomsheet.dart';
import '../widget/custom_snackbar.dart';
import '../widget/submit_button.dart';

class Detailpage extends StatefulWidget {
  final StudentsModel studentDetails;
  const Detailpage({
    super.key,
    required this.studentDetails,
  });

  @override
  State<Detailpage> createState() => _DetailpageState();
}

class _DetailpageState extends State<Detailpage> {
  final _formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var ageController = TextEditingController();
  var phoneController = TextEditingController();
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.studentDetails.name;
    ageController.text = widget.studentDetails.age;
    phoneController.text = widget.studentDetails.phoneno;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DetailsEditProvider>().initializeStudent(
            widget.studentDetails.imageurl ?? '',
            widget.studentDetails.gender,
          );
    });
  }

  void enableEditing() {
    setState(() {
      _isEditing = true;
    });
  }

 Future<void> updateStudentDetails() async {
  try {
    final detailsProvider = context.read<DetailsEditProvider>();
    final updatedStudent = StudentsModel(
      id: widget.studentDetails.id,
      name: nameController.text,
      gender: detailsProvider.selectedGender ?? widget.studentDetails.gender,
      phoneno: phoneController.text,
      age: ageController.text,
      imageurl: detailsProvider.selectedImage?.path ?? widget.studentDetails.imageurl,
    );

    // Update the database
    await Provider.of<StudentProvider>(context, listen: false)
        .updateStudent(updatedStudent);

    // Update the DetailsEditProvider with the new gender

    if (mounted) {
                _isEditing = false;

      Navigator.pop(context);
    }
       await Future.delayed(Duration(milliseconds: 100));
    detailsProvider.updateSelectedGender(updatedStudent.gender);
 

    CustomSnackBarCustomisation.show(
      context: context,
      message: 'Update Successful',
      messageColor: green,
      icon: Icons.cloud_done,
      iconColor: green,
    );
  } catch (e) {
    log('$e');
    CustomSnackBarCustomisation.show(
      context: context,
      message: 'Error Updating student',
      messageColor: red,
      icon: Icons.running_with_errors_rounded,
      iconColor: red,
    );
  }
}

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: CustomAppbar(title: _isEditing ? 'Updated' : 'Specification'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: Form(
            key: _formKey,
            child: Consumer<DetailsEditProvider>(
              builder: (context, detailsProvider, child) {
                return ListView(
                  children: [
                    hight30,
                    Center(
                      child: GestureDetector(
                          onTap: _isEditing
                              ? () => detailsProvider.pickImageFromGallery()
                              : null,
                          child: Container(
                            height: screenHeight * 0.15,
                            width: screenHeight * 0.15,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 236, 236, 236),
                              shape: BoxShape.circle,
                            ),
                            child: ClipOval(
                              child: detailsProvider.selectedImage != null
                                  ? Image.file(
                                      detailsProvider.selectedImage!,
                                      fit: BoxFit.cover,
                                      width: screenHeight * 0.15,
                                      height: screenHeight * 0.15,
                                    )
                                  : (widget.studentDetails.imageurl != null &&
                                          widget.studentDetails.imageurl!
                                              .isNotEmpty)
                                      ? Image.file(
                                          File(widget.studentDetails.imageurl!),
                                          fit: BoxFit.cover,
                                          width: screenHeight * 0.15,
                                          height: screenHeight * 0.15,
                                        )
                                      : Lottie.asset(
                                          'assets/addimage.json',
                                          fit: BoxFit.contain,
                                          width: screenHeight * 0.25,
                                          height: screenHeight * 0.25,
                                        ),
                            ),
                          )),
                    ),
                    EditTextFiled(
                        widget: widget,
                        nameController: nameController,
                        isEditing: _isEditing,
                        ageController: ageController,
                        phoneController: phoneController),
                    GenderSelection(
                      selectedGender: _isEditing
                          ? detailsProvider.selectedGender ??
                              widget.studentDetails.gender
                          : widget.studentDetails.gender,
                      onChanged: _isEditing
                          ? (value) {
                              if (value != detailsProvider.selectedGender) {
                                detailsProvider.updateSelectedGender(value!);
                              }
                            }
                          : (_) {},
                    ),
                    Lottie.asset(
                      'assets/loading.json',
                      fit: BoxFit.contain,
                      width: screenHeight * 0.20,
                      height: screenHeight * 0.20,
                    ),
                    ActionButtons(
                        onCancelPressed: () {
                          showModalBottomSheet(
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20)),
                            ),
                            builder: (context) {
                              return CustomeBottmSheet(
                                onConfirm: () async {
                                  await Provider.of<StudentProvider>(context,
                                          listen: false)
                                      .deleteStudent(widget.studentDetails.id!);
                                  CustomSnackBarCustomisation.show(
                                    context: context,
                                    message: 'Delete successfully',
                                    messageColor: red,
                                    icon: Icons.delete_sweep_outlined,
                                    iconColor: red,
                                  );
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                color: red,
                                icon: Icons.delete_sweep_outlined,
                                title: 'Delete Student Details',
                                description:
                                    'After confirming, the data will be permanently deleted from the database',
                              );
                            },
                          );
                        },
                        onSubmitPressed: () {
                          if (!_isEditing) {
                            enableEditing();
                          } else {
                            showModalBottomSheet(
                              context: context,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20)),
                              ),
                              builder: (context) {
                                return CustomeBottmSheet(
                                  onConfirm: updateStudentDetails,
                                  icon: Icons.update,
                                  color: Colors.blue,
                                  title: 'Update Student Details',
                                  description:
                                      'After confirming, the current student details will be updated in the database.',
                                );
                              },
                            );
                          }
                        },
                        cancelText: 'Delete',
                        submitText: _isEditing ? 'Update' : 'Edit')
                  ],
                );
              },
            )),
      ),
    );
  }
}
