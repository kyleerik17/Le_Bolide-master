import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Modal2Page extends StatefulWidget {
  const Modal2Page({super.key});

  @override
  _Modal2PageState createState() => _Modal2PageState();
}

class _Modal2PageState extends State<Modal2Page> {
  String _selectedOption = 'Pertinence';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, // Ajout de la couleur de fond blanche
      child: FractionallySizedBox(
        heightFactor: 0.8,
        child: Padding(
          padding: EdgeInsets.all(4.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      "Option de tri",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFEBEBEB),
                      ),
                      padding: EdgeInsets.all(0.w),
                      child: Image.asset(
                        'assets/icons/close.png',
                        width: 12.w,
                        height: 12.w,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 3.h),
              _buildRadioOption('Pertinence'),
              SizedBox(height: 2.h),
              _buildRadioOption('Prix croissant'),
              SizedBox(height: 2.h),
              _buildRadioOption('Prix décroissant'),
              SizedBox(height: 2.h),
              _buildRadioOption('Popularité'),
              SizedBox(height: 2.h),
              _buildRadioOption('Meilleures notes'),
              Spacer(),
              Center(
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFF1A1A1A),
                    padding:
                        EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 40.w),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1.w),
                    ),
                  ),
                  child: Text(
                    "Valider",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Cabin',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRadioOption(String value) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedOption = value;
        });
      },
      child: Row(
        children: [
          Image.asset(
            _selectedOption == value
                ? 'assets/icons/cs1.png'
                : 'assets/icons/unc.png',
            width: 6.w,
            height: 6.w,
          ),
          SizedBox(width: 4.w),
          Text(value,
              style: TextStyle(
                  fontSize: 12.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
