import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Slider1Page extends StatefulWidget {
  const Slider1Page({Key? key}) : super(key: key);

  @override
  _Slider1State createState() => _Slider1State();
}

class _Slider1State extends State<Slider1Page> {
  int _currentIndex = 0;

  final List<String> _images = [
    'assets/images/slidee.jpeg',
    'assets/images/slidee.jpeg',
    'assets/images/slidee.jpeg',
    'assets/images/slidee.jpeg',
    'assets/images/slidee.jpeg',
    'assets/images/slidee.jpeg',
    'assets/images/slidee.jpeg',
  ];

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

class SlideItem extends StatelessWidget {
  final String image;
  final VoidCallback? onPreviousPressed;
  final VoidCallback? onNextPressed;

  const SlideItem({
    Key? key,
    required this.image,
    this.onPreviousPressed,
    this.onNextPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(0.5.h),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.center,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color(0xFFFFFFFF).withOpacity(0),
                        const Color(0xFF1A1A1A).withOpacity(0.8),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 30,
          left: 1,
          child: GestureDetector(
            onTap: onPreviousPressed,
            child: Image.asset(
              'assets/icons/gc.png',
              width: 10.w,
              height: 12.h,
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          top: 30,
          right: 1,
          child: GestureDetector(
            onTap: onNextPressed,
            child: Image.asset(
              'assets/icons/dt.png',
              width: 10.w,
              height: 12.h,
            ),
          ),
        ),
      ],
    );
  }
}
