import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Add3Page extends StatefulWidget {
  const Add3Page({Key? key}) : super(key: key);

  @override
  _Add3PageState createState() => _Add3PageState();
}

class _Add3PageState extends State<Add3Page> {
  bool _showQuantityControls = false;
  int _quantity = 1;

  void _incrementQuantity() {
    setState(() {
      if (_quantity < 2) {
        _quantity++;
      }
    });
  }

  void _decrementQuantity() {
    setState(() {
      if (_quantity > 1) {
        _quantity--;
      } else {
        _showQuantityControls = false;
        _quantity = 1;
      }
    });
  }

  void _toggleQuantityControls() {
    setState(() {
      _showQuantityControls = !_showQuantityControls;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 4.5.h,
        child: SizedBox(
          width: 34.w, // Assure que les deux éléments aient la même largeur
          child: !_showQuantityControls
              ? TextButton(
                  onPressed: _toggleQuantityControls,
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFF1A1A1A),
                    padding:
                        EdgeInsets.symmetric(vertical: 1.h, horizontal: 9.w),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1.5.w),
                    ),
                  ),
                  child: Text(
                    "Ajouter",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Cabin',
                    ),
                  ),
                )
              : Padding(
                  padding: EdgeInsets.symmetric(vertical: 0.5.h),
                  child: Container(
                    width: 50
                        .w, // Assure que les deux éléments aient la même largeur
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(1.5.w),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 31,
                          height: 24,
                          child: IconButton(
                            onPressed: _decrementQuantity,
                            icon: const Icon(Icons.remove),
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                          ),
                        ),
                        const VerticalDivider(
                          color: Colors.grey,
                          thickness: 1,
                        ),
                        SizedBox(width: 1.w),
                        Text(
                          '$_quantity',
                          style: TextStyle(fontSize: 14.sp),
                        ),
                        SizedBox(width: 1.w),
                        const VerticalDivider(
                          color: Colors.grey,
                          thickness: 1,
                        ),
                        SizedBox(
                          width: 31.5,
                          height: 24,
                          child: IconButton(
                            onPressed: _incrementQuantity,
                            icon: const Icon(Icons.add),
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
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
