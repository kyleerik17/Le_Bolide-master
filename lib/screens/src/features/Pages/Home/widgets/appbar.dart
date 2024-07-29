import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../Menu/pages/menu.dart';
import '../Pay/Pages/pages.dart';

class AppBarWidget extends StatefulWidget {
  final int partId;
  final int userId;
  const AppBarWidget({Key? key, required this.partId, required this.userId})
      : super(key: key);

  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24.w,
      color: const Color(0xFFFFFFFF),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 2.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left: Menu Icon
            GestureDetector(
              onTap: () {
                showGeneralDialog(
                  context: context,
                  barrierDismissible: true,
                  barrierLabel: MaterialLocalizations.of(context)
                      .modalBarrierDismissLabel,
                  barrierColor: Colors.black.withOpacity(0.5),
                  transitionDuration: const Duration(milliseconds: 200),
                  pageBuilder: (BuildContext buildContext,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation) {
                    return FractionallySizedBox(
                      widthFactor: 0.6,
                      heightFactor: 1,
                      alignment: Alignment.centerLeft,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(-1.0, 0.0),
                          end: Offset.zero,
                        ).animate(animation),
                        child: Material(
                          type: MaterialType.transparency,
                          child: Container(
                            color: Colors.white,
                            child:
                                MenuPage(partId: widget.partId, userId: widget.userId),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              child: Padding(
                padding: EdgeInsets.only(left: 4.0.w),
                child: Image.asset(
                  'assets/icons/menu.png',
                  color: Colors.black,
                ),
              ),
            ),

            Image.asset(
              'assets/icons/ll.png',
              fit: BoxFit.contain,
              height: 13.w,
            ),

            // Right: Payment Icon
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PayPage(
                            partId: widget.partId,
                            userId: widget.userId,
                            cartItems: [],
                          )),
                );
              },
              child: Padding(
                padding: EdgeInsets.only(right: 0.w),
                child: Image.asset(
                  'assets/icons/carte.png',
                  width: 10.w,
                  height: 6.0.h,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
