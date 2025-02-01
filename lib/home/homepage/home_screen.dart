import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:provider_student_management/home/homepage/widget/custom_data_list.dart';
import 'package:provider_student_management/provider/students_search_provider.dart';
import '../../core/colors/colors.dart';
import '../../core/constant.dart';
import '../add_student/add_student.dart';
import '../spec/detailpage.dart';
import '../widget/appbar.dart';
import 'widget/search_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();


  @override
  void initState(){
   super.initState();
   Future.delayed(Duration.zero, (){
    // ignore: use_build_context_synchronously
    Provider.of<StudentsSearchProvider>(context, listen:  false).fetchStudents();
   });
  }

  @override
  Widget build(BuildContext context) {
       final searchProvider = Provider.of<StudentsSearchProvider>(context);
       final studentList = searchProvider.filteredStudents;

        double screenHeight = MediaQuery.of(context).size.height;
        double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: white,
      appBar: CustomAppbar(title: 'Students Management'),
      body: Padding(
  padding: const EdgeInsets.symmetric(horizontal: 10.0),
  child: Column(
    children: [
      Searchbarmain(hintText: 'Search for Student', onSearchPressed: (searchTerm){  
        searchProvider.searchStudents(searchTerm);
      },
      controller: searchController,
      ),
      hight10,
      studentList.isEmpty
      ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/purchase_empty.json',
                width: screenWidth * 0.5,
                height: screenHeight * 0.3,
              ),
              SizedBox(height: screenHeight * 0.02),
              Text(
                'No records found!',
                style: TextStyle(
                  fontSize: 16,
                  color: const Color.fromARGB(255, 129, 129, 129),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ):Expanded( 
          child: ListView.separated(
            separatorBuilder: (context, index) => SizedBox(height: 10),
            itemCount: studentList.length,
            itemBuilder: (context, index) {
              final student = studentList[index];
              return ShowSaleAdded(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Detailpage(studentDetails: student),)).then((_){
                    searchProvider.fetchStudents();
                  });
                },
                name: student.name, 
                age: student.age.toString(), 
                imagePath: student.imageurl ?? '',
                phone: student.phoneno.toString(),
                gender: student.gender);
            },
          ),
        )
    ],
  ),
),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddStudents(),
              ));
              
        },
        backgroundColor: black,
        child: const Icon(
          Icons.person_add,
          color: white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}







