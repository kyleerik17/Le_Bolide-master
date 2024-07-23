import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ModelDropdown extends StatelessWidget {
  final String? selectedModel;
  final ValueChanged<String?> onChanged;

  const ModelDropdown({
    Key? key,
    required this.selectedModel,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Modèle',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: 12.sp,
          ),
        ),
        SizedBox(height: 1.h),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            hintText: 'Choisissez votre modèle',
            border: const OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 2.w),
          ),
          value: selectedModel,
          items: [
            'Tucson',
            'Nexo',
            'Santa Fe',
            'Kona',
            'i30',
            'i20',
            'Ioniq 5'
          ].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: onChanged,
          icon: ImageIcon(
            const AssetImage('assets/icons/dw.png'),
            size: 4.w,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
