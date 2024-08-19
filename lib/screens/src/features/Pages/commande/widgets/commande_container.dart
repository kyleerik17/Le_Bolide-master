import 'package:flutter/material.dart';
import 'package:Bolide/screens/src/features/Pages/commande/pages/details_commande_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class CommandeContainer extends StatefulWidget {
  final String price;
  final String description;
  final String assetIcon;
  final int partId;
  final int userId;
  final String status;
  final String createdAt;

  const CommandeContainer({
    Key? key,
    required this.price,
    required this.description,
    required this.assetIcon,
    required this.partId,
    required this.userId,
    required this.status,
    required this.createdAt,
  }) : super(key: key);

  @override
  _CommandeContainerState createState() => _CommandeContainerState();
}

class _CommandeContainerState extends State<CommandeContainer> {
  String _formatDate(String date) {
    DateTime parsedDate = DateTime.parse(date);
    return DateFormat('dd/MM/yy').format(parsedDate);
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'en cours':
      case 'e':
        return const Color(0xFFFF9D0B); // Orange
      case 'livrée':
      case 't':
        return const Color(0xFF09C961); // Green
      case 'annulée':
      case 'a':
        return const Color(0xFFD93C0A); // Red
      default:
        return Colors.grey;
    }
  }

  String _getStatusLabel(String status) {
    switch (status.toLowerCase()) {
      case 'en cours':
      case 'e':
        return 'En cours';
      case 'livrée':
      case 't':
        return 'Livrée';
      case 'annulée':
      case 'a':
        return 'Annulée';
      default:
        return 'Inconnu';
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = _formatDate(widget.createdAt);
    String statusLabel = _getStatusLabel(widget.status);
    Color statusColor = _getStatusColor(widget.status);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 500),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Affichage de la date formatée en haut
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.w),
            child: Text(
              formattedDate,
              style: const TextStyle(
                fontSize: 16,
                fontFamily: 'Cabin',
                fontWeight: FontWeight.w500,
                color: Color(0xFF1A1A1A),
              ),
            ),
          ),
          // Container contenant les détails de la commande
          Container(
            width: 90.w,
            height: 25.w,
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
                        Row(
                          children: [
                            SvgPicture.asset(
                              widget.assetIcon,
                              width: 5.w,
                              height: 5.w,
                            ),
                            SizedBox(width: 2.w),
                            Expanded(
                              child: Text(
                                widget.description,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Color(0xFF1A1A1A),
                                  fontFamily: "Cabin",
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: statusColor,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(4),
                                  bottomLeft: Radius.zero,
                                  bottomRight: Radius.zero,
                                  topRight: Radius.zero,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  statusLabel,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.5.h),
                        Text(
                          widget.price,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Color(0xFF1A1A1A),
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
