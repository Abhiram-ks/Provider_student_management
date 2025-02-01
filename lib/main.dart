import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:provider_student_management/db/provider_db_helper.dart';
import 'package:provider_student_management/provider/students_search_provider.dart';
import 'package:provider_student_management/start/splash_screen.dart';
import 'core/colors/colors.dart';
import 'provider/details_edit_provider.dart';
import 'provider/student_form_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final studentProvider = StudentProvider();
   await studentProvider.initializeDatabase(); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => StudentProvider()),
        ChangeNotifierProvider(create: (context) => StudentFormProvider()),
        ChangeNotifierProvider(create: (context) => DetailsEditProvider()),
        ChangeNotifierProxyProvider<StudentProvider,StudentsSearchProvider>(
          create: (context) => StudentsSearchProvider(Provider.of<StudentProvider>(context, listen: false)),
          update: (context, studentProvider, previous) => StudentsSearchProvider(studentProvider),
        ),
      ],
      child: MaterialApp(
        title: 'STUDENT DATABASE',
        debugShowCheckedModeBanner: false,
         theme: ThemeData(
         primarySwatch: primaryColor,
         scaffoldBackgroundColor: white,
         fontFamily: GoogleFonts.montserrat().fontFamily,
         textTheme: TextTheme(
          bodyLarge: TextStyle(color: black),
          bodyMedium: TextStyle(color:black),
          bodySmall: TextStyle(color:black), 
         )
        ),
        home: SplashScreen(),
      ),
    );
  }
}

