import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import '../../../../../../gen/assets.gen.dart';
import '../../registration/pages/pages.dart';

List<String> titles = [
  "Trouvez vos pièces détachées devient si simple",
  "Explorez le catalogue le plus complet au Sénégal",
  "Service rapide et assistance dédiée pour vous guider",
];
List<Widget> images = [
  Assets.images.Onboarding1.image(),
  Assets.images.Onboarding2.image(),
  Assets.images.onboarding3.image(),
];

List<String> descriptions = [
  "Utilisez notre moteur de recherche intelligent pour trouver exactement ce dont vous avez besoin en quelques secondes.",
  "Découvrez notre vaste sélection de pièces détachées couvrant toutes les marques et modèles.",
  "Bénéficiez d'une livraison rapide et d'un support client à votre écoute.",
];

class OnboardingPage extends StatefulWidget {
  final int partId;
  final int userId;
  const OnboardingPage({
    Key? key,
    required this.partId,
    required this.userId,
  }) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    double currentProgress = ((currentPage + 1) / images.length);
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(4.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10.w,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      bottom: 0,
                      child: InkWell(
                        onTap: () {
                          if (currentPage > 0) {
                            setState(() {
                              currentPage--;
                            });
                          }
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color(0xFFEBEBEB),
                            shape: BoxShape.circle,
                          ),
                          padding: EdgeInsets.all(2.w),
                          child: Icon(Icons.arrow_back_ios_new, size: 3.w),
                        ),
                      ),
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icons/lgo.png',
                            width: 58.w,
                            height: 37.h,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.w),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4.w),
                  child: LinearProgressIndicator(
                    backgroundColor: const Color(0xff373737).withOpacity(0.3),
                    value: currentProgress,
                    valueColor: const AlwaysStoppedAnimation(Colors.black),
                    minHeight: 1.w,
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                titles[currentPage],
                style: TextStyle(
                  fontSize: 26.sp,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 5.w),
              SizedBox(width: 60.w, height: 60.w, child: images[currentPage]),
              SizedBox(height: 2.h),
              Padding(
                padding: const EdgeInsets.all(4),
                child: Text(
                  descriptions[currentPage],
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: "Cabin",
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Spacer(),
              if (currentPage < 2)
                InkWell(
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 8.w,
                  ),
                  onTap: () {
                    setState(() {
                      currentPage++;
                    });
                  },
                ),
              if (currentPage == 2)
                TextButton(
                  onPressed: () {
                    _showCenteredDialog();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A1A1A),
                    padding:
                        EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 13.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1.h),
                    ),
                  ),
                  child: Text(
                    "Démarrer",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontFamily: "Cabin",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  void _showCenteredDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: const Color(0x545458).withOpacity(0.95),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(1.5.h),
          ),
          child: Padding(
            padding: EdgeInsets.all(4.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Voulez-vous activer les notifications ?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontFamily: "Cabin",
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 2.h),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration:
                                const Duration(milliseconds: 300),
                            pageBuilder: (_, __, ___) => RegistrationPage(
                              partId: widget.partId,
                              userId: widget.userId,
                            ),
                            transitionsBuilder: (_, animation, __, child) {
                              return SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(1.0, 0.0),
                                  end: Offset.zero,
                                ).animate(animation),
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                      child: Text(
                        "Continuer",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 14.sp,
                          fontFamily: "Cabin",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); // Close the dialog
                      },
                      child: Text(
                        "Annuler",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14.sp,
                          fontFamily: "Cabin",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
