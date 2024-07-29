import 'package:flutter/material.dart';
import 'package:le_bolide/screens/src/features/Pages/Assistance/pages/assistance_page.dart';
import 'package:sizer/sizer.dart';

import '../../Home/pages/home_page.dart';
import '../../commande/pages/pages.dart';

class FavorisBottomNavBar extends StatefulWidget {
  final int partId;
  final int userId;
  final Function(int) onTap;

  const FavorisBottomNavBar({
    Key? key,
    required this.onTap,
    required this.partId,
    required this.userId,
  }) : super(key: key);

  @override
  _FavorisBottomNavBarState createState() => _FavorisBottomNavBarState();
}

class _FavorisBottomNavBarState extends State<FavorisBottomNavBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Spacer(),
            SizedBox(
              height: 1.5.w,
              width: 20.w,
              child: const LinearProgressIndicator(
                backgroundColor: Colors.white,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                value: 2,
              ),
            ),
          ],
        ),
        BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedFontSize: 10.sp,
          unselectedFontSize: 10.sp,
          unselectedItemColor: Colors.grey,
          currentIndex: _selectedIndex,
          items: [
            BottomNavigationBarItem(
              icon: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = 0;
                  });
                  widget.onTap(0);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            HomePage(partId: widget.partId, userId:widget.userId)),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.only(bottom: 1.w),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/icons/ho.png',
                        height: 8.w,
                        width: 8.w,
                        color: Color(0xFF737373),
                      ),
                      const Text(
                        'Acceuil',
                        style: TextStyle(
                          fontFamily: "Cabin",
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF737373),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = 1;
                  });
                  widget.onTap(1);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CommandePage(
                            partId: widget.partId, userId: widget.userId)),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.only(bottom: 1.w),
                  child: Column(
                    children: [
                      Image.asset('assets/icons/reciept.png',
                          height: 8.w, width: 8.w, color: Color(0xFF737373)),
                      const Text('Commandes',
                          style: TextStyle(
                            fontFamily: "Cabin",
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF737373),
                          )),
                    ],
                  ),
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: GestureDetector(
                onTap: () {},
                child: Container(),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = 3;
                  });
                  widget.onTap(3);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AssistancePage(
                              partId: widget.partId,
                              userId: widget.userId
                            )),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.only(bottom: 1.w),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/icons/ring.png',
                        height: 8.w,
                        width: 8.w,
                      ),
                      const Text(
                        'Assistance',
                        style: TextStyle(
                          fontFamily: "Cabin",
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF737373),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = 4;
                  });
                  widget.onTap(4);
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => const FavorisPage()),
                  // );
                },
                child: Padding(
                  padding: EdgeInsets.only(bottom: 1.w),
                  child: Column(
                    children: [
                      Image.asset('assets/icons/hrt2.png',
                          height: 8.w, width: 8.w, color: Colors.black),
                      const Text(
                        'Favoris',
                        style: TextStyle(
                            fontFamily: "Cabin",
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
              label: '',
            ),
          ],
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
            widget.onTap(index);
          },
        ),
      ],
    );
  }
}
