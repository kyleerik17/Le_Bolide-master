import 'package:flutter/material.dart';
import 'package:le_bolide/src/features/Pages/Assistance/pages/assistance_page.dart';
import 'package:le_bolide/src/features/Pages/commande/pages/commande_page.dart';
import 'package:sizer/sizer.dart';

import '../../Favoris/Pages/favoris.dart';
import '../../Home/pages/home_page.dart';

class AssisBottom extends StatefulWidget {
  final Function(int) onTap;

  const AssisBottom({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  _AssisBottomState createState() => _AssisBottomState();
}

class _AssisBottomState extends State<AssisBottom> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            SizedBox(width: 60.w),
            SizedBox(
              height: 1.5.w,
              width: 20.w,
              child: const LinearProgressIndicator(
                backgroundColor: Colors.white,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                value: 1,
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
                    MaterialPageRoute(builder: (context) => const HomePage()),
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
                      ),
                      const Text(
                        'Acceuil',
                        style: TextStyle(
                          fontFamily: "Cabin",
                          fontWeight: FontWeight.w600,
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
                    MaterialPageRoute(builder: (context) => CommandePage()),
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
                // onTap: () {
                //   setState(() {
                //     _selectedIndex = 3;
                //   });
                //   widget.onTap(3);
                //    Navigator.pushReplacement(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => const AssistancePage()),
                //   );
                // },
                child: Padding(
                  padding: EdgeInsets.only(bottom: 1.w),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/icons/ringe.png',
                        height: 8.w,
                        width: 8.w,
                      ),
                      const Text(
                        'Assistance',
                        style: TextStyle(
                          fontFamily: "Cabin",
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1A1A1A),
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
                   Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FavorisPage()),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.only(bottom: 1.w),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/icons/cr.png',
                        height: 8.w,
                        width: 8.w,
                      ),
                      const Text(
                        'Favoris',
                        style: TextStyle(
                          fontFamily: "Cabin",
                          color: Color(0xFF737373),
                          fontWeight: FontWeight.w600,
                        ),
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
