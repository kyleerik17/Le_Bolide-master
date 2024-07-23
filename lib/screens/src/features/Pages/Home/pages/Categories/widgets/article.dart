import 'package:flutter/material.dart';

class ArticlePage extends StatelessWidget {
  const ArticlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 4),
        _buildArticle(
          imageUrl: 'assets/images/pn2.png',
          title: 'Radar Rivera PRO 2 165/65 R13 77T',
          iconUrl: 'assets/icons/sun.png',
          description: 'Pneu été',
          price: '38 000 F',
        ),
        _buildArticle(
          imageUrl: 'assets/images/pn1.jpeg',
          title: 'Continental TS860 155/70 R13 75T',
          iconUrl: 'assets/icons/hv.png',
          description: 'Pneu hiver',
          price: '59 000 F',
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
      children: [
        Container(
          width: 300,
          height: 150,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imageUrl),
                    fit: BoxFit.contain,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Image.asset(
                        iconUrl,
                        width: 20,
                        height: 20,
                      ),
                      SizedBox(width: 10),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    price,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
