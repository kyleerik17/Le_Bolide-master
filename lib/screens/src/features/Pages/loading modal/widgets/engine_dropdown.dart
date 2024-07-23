import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class EngineDropdown extends StatelessWidget {
  final String? selectedEngine;
  final ValueChanged<String?> onChanged;

  const EngineDropdown({
    Key? key,
    required this.selectedEngine,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Motorisation',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: 12.sp,
          ),
        ),
        SizedBox(height: 1.h),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            hintText: 'Choisissez votre moteur',
            border: const OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 2.w),
          ),
          value: selectedEngine,
          items: [
            'Essence - 3.3 4WD (199 KW / 270 CV)',
            'Essence - 2.0 (197 KW / 268 CV)',
            'Essence - 2.0 4WD (197 KW / 268 CV)',
            'Essence - 3.3 XL 4WD (218 KW / 296 CV)',
            'Essence - 3.0 GDi (194 KW / 264 CV)',
            'Diesel - 2.2 CRDi AWD (142 KW / 193 CV)',
            'Diesel - 2.2 CRDi AWD (149 KW / 202 CV)',
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
