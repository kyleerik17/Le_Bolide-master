import 'package:flutter/material.dart';
import 'package:Bolide/screens/src/features/Pages/commande/pages/details_commande_page.dart';
import 'package:sizer/sizer.dart';

class CommandeContainer extends StatefulWidget {
  final String price;
  final String description;
  final String assetIcon;
  final int partId;
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
  _CommandeContainerState createState() => _CommandeContainerState();
}

class _CommandeContainerState extends State<CommandeContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return DetailsCommandePage(
                partId: widget.partId,
                userId: widget.userId,
                price: widget.price,
              );
            },
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.easeInOut;

              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);

              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            },
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
                      widget.price,
                      style: const TextStyle(
                        fontSize: 17,
                        color: Color(0xFF1A1A1A),
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 1.5.h),
                    Row(
                      children: [
                        ImageIcon(
                          AssetImage(widget.assetIcon),
                          size: 5.w,
                          color: Color(0xFF1A1A1A),
                        ),
                        SizedBox(width: 2.w),
                        Expanded(
                          child: Text(
                            widget.description,
                            style: const TextStyle(
                              fontSize: 17,
                              color: Color(0xFF1A1A1A),
                              fontFamily: "Cabin",
                              fontWeight: FontWeight.w400,
                            ),
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
