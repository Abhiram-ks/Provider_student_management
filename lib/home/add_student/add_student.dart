
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:provider_student_management/provider/student_form_provider.dart';
import '../../core/colors/colors.dart';
import '../../core/constant.dart';
import '../../db/model.dart';
import '../../db/provider_db_helper.dart';
import '../homepage/home_screen.dart';
import '../widget/appbar.dart';
import '../widget/custom_snackbar.dart';
import '../widget/submit_button.dart';
import 'widget/custom_text.dart';
import 'widget/gender_selection.dart';
import 'widget/validation.dart';


class AddStudents extends StatelessWidget {
   AddStudents({super.key});
   final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final phonenoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
  double screenHeight = MediaQuery.of(context).size.height;
  final studentFormProvider = Provider.of<StudentFormProvider>(context);
  

    return Consumer<StudentFormProvider>(
      builder: (context, value, child) =>Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: white,
        appBar: CustomAppbar(title: 'Student Information'),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                hight30,
                Center(
                    child: GestureDetector(
                  onTap: () => studentFormProvider.pickImageFromGallery(),
                  child: ClipOval(
                    child: Container(
                        height: screenHeight * 0.15,
                        width: screenHeight * 0.15,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 236, 236, 236),
                          shape: BoxShape.circle,
                        ),
                        child: studentFormProvider.selectedImage != null
                            ? ClipOval(
                                child: Image.file(
                                  studentFormProvider.selectedImage!,
                                  fit: BoxFit.cover,
                                  width: screenHeight * 0.15,
                                  height: screenHeight * 0.15,
                                ),
                              )
                            : Lottie.asset( 'assets/addimage.json',fit: BoxFit.contain,
                                width: screenHeight * 0.25, height: screenHeight * 0.25,)),
                  ),)),
                hight10,  CustomTextFormFild(  icon: Icons.person, labelText: 'Name',hintText: 'Enter student name',
                controller: nameController, validate: NameValidator.validate,),
                PhoneNumberFiled(
                  icon: Icons.cake,
                  labelText: 'Age',
                  hintText: 'Enter student age',
                  controller: ageController,
                  validate: AgeValidator.validate,
                ),
                PhoneNumberFiled(
                  icon: Icons.phone,
                  labelText: 'Phone Number',
                  hintText: 'Enter Phone Number',
                  controller: phonenoController,
                  validate: PhoneNumberValidator.validate,
                ),
                hight10,
                Text('     Select Gender'),
                GenderSelection(
                  selectedGender: studentFormProvider.selectedGender,
                  onChanged: studentFormProvider.changeGender
                  ,),
                SizedBox(
                  height: 130,
                ),
                ActionButtons(
                  onCancelPressed: () {
                   Navigator.pop(context, true); 
                  },
                  onSubmitPressed: () async {
                    if (formKey.currentState!.validate()) {
                      if (studentFormProvider.selectedImage == null) {
                        CustomSnackBarCustomisation.show(
                          context: context,
                          message: 'Pick Image and process',
                          messageColor: blue,
                          icon: Icons.photo_size_select_large_rounded,
                          iconColor: blue,
                        );
                        return;
                      }
      
                      final student = StudentsModel(
                        name: nameController.text,
                        gender: studentFormProvider.selectedGender,
                        phoneno: phonenoController.text,
                        imageurl:  studentFormProvider.selectedImage?.path,
                        age: ageController.text,
                      );
                      // ignore: avoid_print
                      print("Student data: ${student.name}, ${student.gender}, ${student.phoneno}, ${student.age}, ${student.imageurl}");
                       await Provider.of<StudentProvider>(context, listen: false).addStudent(student);
                       
                      // ignore: use_build_context_synchronously
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
                      CustomSnackBarCustomisation.show(
                        // ignore: use_build_context_synchronously
                        context: context,
                        message: 'Data added Successfully',
                        messageColor: Colors.green,
                        icon: Icons.cloud_done,
                        iconColor: green,
                      );
                      // ignore: 
                       nameController.clear();
                       phonenoController.clear();
                       ageController.clear();
                       studentFormProvider.clearForm();
                    }
                  },
                  cancelText: 'Cancel',
                  submitText: 'Submit',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



