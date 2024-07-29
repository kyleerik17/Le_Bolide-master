import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Add3Page extends StatefulWidget {
  final int initialQuantity;

  const Add3Page({Key? key, required this.initialQuantity}) : super(key: key);

  @override
  _Add3PageState createState() => _Add3PageState();
}

class _Add3PageState extends State<Add3Page> {
  late int _quantity;

  @override
  void initState() {
    super.initState();
    _quantity = widget.initialQuantity;
  }

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    setState(() {
      if (_quantity > 1) {
        _quantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 4.h,
        child: SizedBox(
          width: 15.w,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 0.5.h),
            child: Container(
              width: 70.w,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Color(0xFFC9CDD2)),
                borderRadius: BorderRadius.circular(1.5.w),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "$_quantity",
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
