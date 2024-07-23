import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SearchBar1Widget extends StatelessWidget {
  const SearchBar1Widget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: () {},
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(1.h),
        ),
        filled: true,
        fillColor: Colors.white,
        hintText: 'Rechercher...',
        hintStyle: TextStyle(
          color: const Color(0xFF737373),
          fontFamily: 'Poppins',
          fontSize: 10.sp,
        ),
        prefixIcon: ImageIcon(
          const AssetImage('assets/icons/search.png'),
          size: 5.w,
          color: Colors.black,
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) => SequencedImageDialog(),
            );
          },
          child: ImageIcon(
            const AssetImage('assets/icons/mc.png'),
            size: 5.w,
            color: Colors.black,
          ),
        ),
      ),
      style: const TextStyle(
        color: Colors.black,
      ),
    );
  }
}

class SequencedImageDialog extends StatefulWidget {
  const SequencedImageDialog({Key? key}) : super(key: key);

  @override
  _SequencedImageDialogState createState() => _SequencedImageDialogState();
}

class _SequencedImageDialogState extends State<SequencedImageDialog> {
  late Timer _timer;
  int _currentIndex = 0;
  List<String> images = [
    'assets/icons/1.png',
    'assets/icons/2.png',
    'assets/icons/3.png',
    'assets/icons/4.png',
  ];
  double _animationDurationInSeconds =
      4.0;
  double _imageDisplayDurationInSeconds =
      0.5; 

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    int totalFrames =
        (_animationDurationInSeconds / _imageDisplayDurationInSeconds).ceil();
    const Duration imageDisplayDuration = Duration(
        milliseconds:
            300); 
    int frame = 0;

    _timer = Timer.periodic(imageDisplayDuration, (timer) {
      setState(() {
        if (frame < totalFrames) {
          _currentIndex = frame % images.length;
          frame++;
        } else {
          _timer.cancel();
          Navigator.of(context).pop();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: Center(
        child: Image.asset(
          images[_currentIndex],
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
