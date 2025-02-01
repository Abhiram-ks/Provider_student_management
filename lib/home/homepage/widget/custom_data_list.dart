import 'dart:io';
import 'package:flutter/material.dart';

import '../../../core/colors/colors.dart';

class ShowSaleAdded extends StatelessWidget {
  final VoidCallback? onTap;
  final String name;
  final String age;
  final String imagePath;
  final String phone;
  final String gender;

  const ShowSaleAdded({
    super.key,
    this.onTap,
    required this.name,
    required this.age,
    required this.imagePath,
    required this.phone,
    required this.gender
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 6,
        shadowColor: black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: screenHeight * 0.15,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      // ignore: deprecated_member_use
                      color: const Color.fromARGB(255, 233, 233, 233),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ClipOval(
                              child: Container(
                                width: 80,
                                height: 80,
                                color: Colors.transparent,
                                child: imagePath.isNotEmpty
                                    ? Image.file(
                                        File(imagePath),
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: double.infinity,
                                      )
                                    : const Icon(
                                        Icons.person,
                                        size: 50,
                                        color: Colors.grey,
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Material(
                            shadowColor: Colors.black,
                            elevation: 25,
                            child: Container(
                              height: screenHeight * 0.14,
                              color: const Color.fromARGB(255, 230, 230, 230),
                              padding:const EdgeInsets.symmetric(horizontal: 8.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: screenHeight * 0.005),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.person,
                                          color: black,
                                          size: 17,
                                        ),
                                        SizedBox(width: screenWidth * 0.02),
                                        Text(
                                          name,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 18.0,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: screenHeight * 0.004),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.cake,
                                          color: Color.fromARGB(
                                              255, 104, 104, 104),
                                          size: 17,
                                        ),
                                        SizedBox(width: screenWidth * 0.02),
                                        Text(
                                          age,
                                          style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 104, 104, 104),
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15.0,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: screenHeight * 0.01),
                                    Container(
                                      padding: const EdgeInsets.all(8.0),
                                      alignment: Alignment.centerLeft,
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        border: Border.all(
                                          color: const Color.fromARGB(255, 212, 212, 212),
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        phone,
                                        style: const TextStyle(
                                          color: Color.fromARGB(
                                              255, 114, 114, 114),
                                          fontSize: 16.0,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 7,
                right: 7,
                child: Icon(
                  gender == 'M' 
                  ? Icons.man_rounded : gender == 'F' 
                      ? Icons.woman_2_outlined : Icons.style_rounded,
                  color: gender == 'M' ? blue : gender == 'F'
                   ? Colors.pink : black,
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
