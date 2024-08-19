import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class SliderPage extends StatefulWidget {
  const SliderPage({Key? key}) : super(key: key);

  @override
  _SliderState createState() => _SliderState();
}

class _SliderState extends State<SliderPage> {
  int _currentIndex = 0;
  List<String> _images = [];

  @override
  void initState() {
    super.initState();
    _fetchImages();
  }

  Future<void> _fetchImages() async {
    final response = await http.get(
      Uri.parse(
          'https://bolide.armasoft.ci/bolide_services/index.php/api/annonces'),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      setState(() {
        _images = data
            .where((item) => item['status'] == '3') // Filtrer par le statut '1'
            .map<String>((item) => item['img'] as String)
            .toList();
      });
    } else {
      // Gérer les erreurs ou afficher un fallback
      // Par exemple, vous pouvez afficher un message ou une image par défaut
    }
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
    return _images.isEmpty
        ? Center(child: CircularProgressIndicator())
        : Column(
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
                          color: _currentIndex == index
                              ? Colors.black
                              : Colors.grey,
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
                Image.network(
                  image,
                  fit: BoxFit.cover,
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
              color: Colors.black,
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
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
