import 'dart:convert';
import 'package:Bolide/screens/src/features/Pages/Home/widgets/slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';

class Slider1Page extends StatefulWidget {
  final String imageUrl; // Ajoutez ce paramètre pour recevoir l'URL de l'image

  const Slider1Page({Key? key, required this.imageUrl}) : super(key: key);

  @override
  _Slider1State createState() => _Slider1State();
}

class _Slider1State extends State<Slider1Page> {
  int _currentIndex = 0;

  late final List<String> _images; // Utilisez late pour initialiser plus tard

  @override
  void initState() {
    super.initState();
    _images = [widget.imageUrl]; // Initialisez la liste avec l'URL reçue
  }

  void _previousImage() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
    }
  }

  void _nextImage() {
    if (_currentIndex < _images.length - 1) {
      setState(() {
        _currentIndex++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
          child: PageView.builder(
            itemCount: _images.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return SlideItem(
                image: _images[index],
                onPreviousPressed: _previousImage,
                onNextPressed: _nextImage,
              );
            },
          ),
        ),
        SizedBox(height: 1.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _images.length,
            (index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 1.w),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(2.sp),
                child: Container(
                  width: 15.sp,
                  height: 4.sp,
                  decoration: BoxDecoration(
                    color: _currentIndex == index ? Colors.black : Colors.grey,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
