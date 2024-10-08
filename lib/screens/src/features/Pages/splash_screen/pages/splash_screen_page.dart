import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:Bolide/screens/src/features/Pages/Home/pages/home_page.dart';
import 'package:sizer/sizer.dart';
import '../../Onboarding/onboarding.dart';

class SplashScreenPage extends StatefulWidget {
  final int partId;
  final int userId;
  const SplashScreenPage(
      {super.key, required this.partId, required this.userId});

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage>
    with TickerProviderStateMixin {
  bool _showFirstImage = false;
  bool _showSecondImage = false;
  bool _isBlackBackground = false;
  bool _showText = false;
  double _imageWidth = 6.w;
  double _imageHeight = 6.w;

  @override
  void initState() {
    super.initState();

    // Vérifiez ici si l'utilisateur est connecté
    if (isUserConnected()) {
      // Si l'utilisateur est connecté, naviguez directement vers HomePage
      _navigateToHomePage();
    } else {
      // Sinon, continuez l'animation normale de SplashScreen
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _showFirstImage = true;
        });

        Future.delayed(const Duration(milliseconds: 800), () {
          setState(() {
            _imageWidth = 150.w;
            _imageHeight = 40.w;
          });

          Future.delayed(const Duration(seconds: 1), () {
            setState(() {
              _isBlackBackground = true;
            });

            Future.delayed(const Duration(milliseconds: 800), () {
              setState(() {
                _showFirstImage = false;
                _showSecondImage = true;
              });

              Future.delayed(const Duration(milliseconds: 500), () {
                setState(() {
                  _showText = true;
                });

                Future.delayed(const Duration(seconds: 1), () {
                  _navigateToOnboardingPage();
                });
              });
            });
          });
        });
      });
    }
  }

  // Méthode pour vérifier si l'utilisateur est connecté
  bool isUserConnected() {
    // Implémentez la logique pour vérifier l'état de connexion de l'utilisateur
    // Par exemple, en vérifiant la présence d'un token ou une session active
    return false; // Remplacez par la condition réelle
  }

  // Navigation vers la page HomePage
  void _navigateToHomePage() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 800),
        pageBuilder: (context, animation, secondaryAnimation) => HomePage(
          partId: widget.partId,
          userId: widget.userId,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset(0.0, 0.0);
          const curve = Curves.easeInOut;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }

  // Navigation vers la page OnboardingPage
  void _navigateToOnboardingPage() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 800),
        pageBuilder: (context, animation, secondaryAnimation) =>
            OnboardingPage(partId: widget.partId, userId: widget.userId),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset(0.0, 0.0);
          const curve = Curves.easeInOut;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.black,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
    ));
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(seconds: 1),
        color: _isBlackBackground ? Colors.black : Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  if (_showFirstImage)
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 800),
                      width: _imageWidth,
                      height: _imageHeight,
                      child: Image.asset(
                        'assets/icons/lgo.png',
                      ),
                    ),
                  AnimatedOpacity(
                    opacity: _showSecondImage ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 800),
                    child: Image.asset(
                      'assets/icons/home.png',
                      height: 40.w,
                      width: 150.w,
                    ),
                  ),
                ],
              ),
              if (_showText)
                Animate(
                  effects: const [
                    MoveEffect(
                      curve: Curves.easeOut,
                      duration: Duration(milliseconds: 800),
                      begin: Offset(200, 0),
                      end: Offset(0, 0),
                    ),
                  ],
                  child: Text(
                    'Bolide',
                    style: TextStyle(
                      color: _isBlackBackground ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 50.sp,
                      fontFamily: "Hemi head",
                      letterSpacing: 0.05,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
