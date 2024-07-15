import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ManufacturerDropdown extends StatelessWidget {
  final String? selectedManufacturer;
  final ValueChanged<String?> onChanged;

  const ManufacturerDropdown({
    Key? key,
    required this.selectedManufacturer,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Fabricant',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: 12.sp,
          ),
        ),
        SizedBox(height: 1.5.h),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            hintText: 'Choisissez une marque',
            border: const OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 2.w),
          ),
          value: selectedManufacturer,
          items: [
            'Peugeot',
            'Nissan',
            'Hyundai',
            'Mercedes-Benz',
            'Ford',
            'Volkswagen',
            'Audi'
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
