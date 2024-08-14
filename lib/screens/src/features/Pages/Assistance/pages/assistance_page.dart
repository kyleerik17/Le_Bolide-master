import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Bolide/screens/src/features/Pages/Home/widgets/appbar.dart';
import 'package:Bolide/screens/src/features/Pages/loading%20modal/pages/search_load_page.dart';

import 'package:sizer/sizer.dart';

import '../widgets/assis_bottom.dart';

class AssistancePage extends StatelessWidget {
  final int partId;
  final int userId;
  const AssistancePage({Key? key, required this.partId, required this.userId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    ));
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8F9),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 3.h),
          AppBarWidget(
            partId: partId,
            userId: userId,
          ),
          SizedBox(height: 2.h),
          Center(
            child: Column(
              children: [
                Container(
                  width: 20.w,
                  height: 20.w,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/icons/rng.png',
                      width: 15.w,
                      height: 15.w,
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'Assistance',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 1.h),
                Center(
                  child: Text(
                    'Trouvez des réponses à vos questions et\n obtenez de l\'aide directement auprès de\n notre équipe de support.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: 'Cabin',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 4.h),
          Padding(
            padding: EdgeInsets.all(4.w),
            child: Container(
              color: Colors.white,
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ListTile(
                    leading: Image.asset(
                      'assets/icons/list.png',
                      width: 20.sp,
                      height: 20.sp,
                    ),
                    title: Text(
                      'FAQ',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: 'Cabin',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: const Text(
                      'Nous avons déjà répondu à la plupart de vos questions. Vous pariez ?',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Cabin',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, size: 14.sp),
                    onTap: () {},
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 0.5,
                    endIndent: 16.sp,
                  ),
                  ListTile(
                    leading: Image.asset(
                      'assets/icons/sms.png',
                      width: 20.sp,
                      height: 20.sp,
                    ),
                    title: Text(
                      'Discutez avec nous',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: 'Cabin',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: const Text(
                      'Des questions ? Parlons-en. Nous sommes là pour vous aider.',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Cabin',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, size: 14.sp),
                    onTap: () {},
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 0.5,
                    endIndent: 16.sp,
                  ),
                  ListTile(
                    leading: Image.asset(
                      'assets/icons/phone.png',
                      width: 20.sp,
                      height: 20.sp,
                    ),
                    title: Text(
                      "Appeler l'assistance",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: 'Cabin',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: const Text(
                      'Des experts prêts à vous aider au bout du fil. N\'hésitez pas à appeler.',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Cabin',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, size: 14.sp),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: AssisBottom(
        onTap: (int) {},
        partId: partId,
        userId: userId,
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: EdgeInsets.only(
              bottom: 5.h), // Ajustez cette valeur selon vos besoins
          width: 20.w,
          height: 20.w,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 500),
                  pageBuilder: (_, __, ___) => SearchLoadPage(
                    partId: partId,
                    userId: userId,
                  ),
                  transitionsBuilder: (_, animation, __, child) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0.0, 1.0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    );
                  },
                ),
              );
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13.w),
            ),
            backgroundColor: Colors.black,
            child: Image.asset(
              'assets/icons/home.png',
              width: 10.w,
              height: 10.h,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
