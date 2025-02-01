import 'package:flutter/material.dart';
import '../../../core/colors/colors.dart';

class GenderSelection extends StatelessWidget {
  final String selectedGender;
  final ValueChanged<String?> onChanged;

  const GenderSelection({super.key, required this.selectedGender, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start, 
      children: [
       Expanded(
         child: RadioListTile(
          activeColor: blue,
          title: const Text('M'),
          value: 'M', 
          groupValue: selectedGender, 
          onChanged: onChanged),
       ),
        Expanded(
          child: RadioListTile(
          activeColor: Colors.pink,
          title: const Text('F'),
          value: 'F', 
          groupValue: selectedGender,
          onChanged: onChanged),
        ),
        Expanded(
          child: RadioListTile(
          activeColor: blue,
          title: const Text('O'),
          value: 'O', 
          groupValue: selectedGender, 
          onChanged: onChanged),
        )
      ],
    );
  }
}



