import 'package:flutter/material.dart';
import 'package:Bolide/screens/src/features/Pages/Favoris/Widgets/add3.dart';
import 'package:Bolide/screens/src/features/Pages/Favoris/Widgets/quantity_widget_fav.dart';
import 'package:sizer/sizer.dart';

class Article4Page extends StatelessWidget {
  final int userId;
  final int partId;
  const Article4Page({Key? key, required this.userId, required this.partId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 4.w),
        _buildArticle(
          imageUrl: 'assets/images/pn2.png',
          title: 'Radar Rivera PRO 2 165/65\nR13 77T',
          iconUrl: 'assets/icons/sun.png',
          description: 'Pneu été',
          price: '38 000 F',
        ),
        SizedBox(height: 4.w),
        _buildArticle(
          imageUrl: 'assets/images/btl.jpeg',
          title: 'O1491E K2 TEXAR XN1',
          iconUrl: 'assets/icons/hle.png',
          description: 'Huile moteur',
          price: '12 000 F',
        ),
        SizedBox(height: 4.w),
        _buildArticle(
          imageUrl: 'assets/images/phr.png',
          title: 'JOHNS Feu arrière pour\nHYUNDAI SANTA FE',
          iconUrl: 'assets/icons/ar.png',
          description: 'Carrosserie',
          price: '38 000 F',
        ),
      ],
    );
  }

  Widget _buildArticle({
    required String imageUrl,
    required String title,
    required String iconUrl,
    required String description,
    required String price,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 92.w,
          height: 30.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(0.5.h),
          ),
          padding: EdgeInsets.symmetric(vertical: 1.w, horizontal: 4.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 20.w,
                height: 25.w,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imageUrl),
                    fit: BoxFit.contain,
                  ),
                  borderRadius: BorderRadius.circular(0.5.h),
                ),
              ),
              SizedBox(width: 2.w),
              Expanded(
                child: ArticleContent(
                  title: title,
                  iconUrl: iconUrl,
                  description: description,
                  price: price,
                  partId: partId,
                  userId: userId,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ArticleContent extends StatefulWidget {
  final String title;
  final String iconUrl;
  final String description;
  final String price;
  final int partId;
  final int userId;

  const ArticleContent({
    Key? key,
    required this.title,
    required this.iconUrl,
    required this.description,
    required this.price,
    required this.partId,
    required this.userId,
  }) : super(key: key);

  @override
  _ArticleContentState createState() => _ArticleContentState();
}

class _ArticleContentState extends State<ArticleContent> {
  String _iconPath = 'assets/icons/cr.png';

  void _toggleIcon() {
    setState(() {
      if (_iconPath == 'assets/icons/hrt2.png') {
        _iconPath = 'assets/icons/cr.png';
      } else {
        _iconPath = 'assets/icons/hrt2.png';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: "Cabin",
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 1.w),
            Row(
              children: [
                Image.asset(
                  widget.iconUrl,
                  width: 6.w,
                  height: 6.w,
                ),
                SizedBox(width: 1.w),
                Text(
                  widget.description,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: "Cabin",
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.price,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontFamily: "Cabin",
                    fontWeight: FontWeight.w500,
                  ),
                ),
                QuantityWidgetFav(
                  userId: widget.userId,
                  partId: widget.partId,
                ),
              ],
            ),
          ],
        ),
        Positioned(
          top: 0,
          right: 0,
          child: GestureDetector(
            onTap: _toggleIcon,
            child: Image.asset(
              _iconPath,
              width: 6.w,
              height: 6.w,
            ),
          ),
        ),
      ],
    );
  }
}
