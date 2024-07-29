import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../pages/pages.dart';

class CommandeContainer extends StatelessWidget {
  final int partId;
  final String price;
  final String description;
  final String assetIcon;
  final int userId;

  const CommandeContainer({
    Key? key,
    required this.price,
    required this.description,
    required this.assetIcon,
    required this.partId,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsCommandePage(
                price: price,
                description: description,
                partId: partId,
                userId: userId),
          ),
        );
      },
      child: Container(
        width: 90.w,
        height: 22.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(0.5.h),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(2.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 2.w),
                    Text(
                      price,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 1.5.h),
                    Row(
                      children: [
                        ImageIcon(
                          AssetImage(assetIcon),
                          size: 5.w,
                          color: Colors.black,
                        ),
                        SizedBox(width: 2.w),
                        Expanded(
                          child: Text(
                            description,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontFamily: "Cabin",
                              fontWeight: FontWeight.w400,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(2.w),
              child: Image.asset(
                'assets/icons/fw.png',
                width: 5.w,
                height: 3.w,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
