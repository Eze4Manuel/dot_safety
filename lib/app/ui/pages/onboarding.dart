import 'package:dot_safety/app/ui/pages/welcome.dart';
import 'package:dot_safety/app/utils/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dot_safety/app/utils/responsive_safe_area.dart';
import 'package:dot_safety/app/utils/device_utils.dart';
import 'package:dot_safety/app/ui/theme/app_colors.dart';
import 'package:dot_safety/app/ui/theme/app_strings.dart';
import 'package:google_fonts/google_fonts.dart';

class Onboarding extends StatefulWidget {
  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {

  @override
  Widget build(BuildContext context) {
    print(SharedPrefs.readSingleString('email'));

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: ResponsiveSafeArea(
        builder: (context, size) {
          return ContentPage();
        },
        key: null,
      ),
    );
  }
}

class ContentPage extends StatefulWidget {
  ContentPageStage createState() => ContentPageStage();
}

class ContentPageStage extends State<ContentPage> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 3),
      height: 10.0,
      width: 10.0,
      decoration: BoxDecoration(
          color: isActive ? AppColors.appPrimaryColor : Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.appColor3, width: 1)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: AppColors.whiteColor,
          child: ListView(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.8,
                color: AppColors.whiteColor,
                child: PageView(
                  physics: ClampingScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  children: <Widget>[
                    Container(
                      height: DeviceUtils.getScaledHeight(context, scale: 0.79),
                      width: DeviceUtils.getScaledWidth(context, scale: 1),
                      color: AppColors.whiteColor,
                      child: SplashViews(context, 'assets/images/icon1.png',
                          Strings.onBoardingTitle1, Strings.onBoardingText1),
                    ),
                    Container(
                      height: DeviceUtils.getScaledHeight(context, scale: 0.79),
                      width: DeviceUtils.getScaledWidth(context, scale: 1),
                      color: AppColors.whiteColor,
                      child: SplashViews(context, 'assets/images/icon2.png',
                          Strings.onBoardingTitle2, Strings.onBoardingText2),
                    ),
                    Container(
                      height: DeviceUtils.getScaledHeight(context, scale: 0.79),
                      width: DeviceUtils.getScaledWidth(context, scale: 1),
                      color: AppColors.whiteColor,
                      child: SplashViews(context, 'assets/images/icon3.png',
                          Strings.onBoardingTitle3, Strings.onBoardingText3),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: DeviceUtils.getScaledHeight(context, scale: 0.04),
              ),
              Container(
                margin: EdgeInsets.only(left: 33),
                color: AppColors.whiteColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: _buildPageIndicator(),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_currentPage == 2) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Welcome()), (Route<dynamic> route) => false);
                        } else {
                          if (_pageController.hasClients) {
                            _pageController.animateToPage(
                              _currentPage + 1,
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                            );
                          }
                        }
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: AppColors.appPrimaryColor),
                        margin: EdgeInsets.symmetric(horizontal: 32),
                        child: Center(
                            child: Icon(Icons.arrow_forward,
                                color: AppColors.whiteColor)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

StatelessWidget SplashViews(
    context, String assetLink, String title, String subText) {
  return Container(
      color: AppColors.whiteColor,
      padding: EdgeInsets.symmetric(
          horizontal: DeviceUtils.getScaledWidth(context, scale: 0.05)),
      height: 100,
      width: 50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            assetLink,
            width: DeviceUtils.getScaledWidth(context, scale: 0.6),
            height: DeviceUtils.getScaledHeight(context, scale: 0.6),
            fit: BoxFit.contain,
          ),
          SizedBox(
            height: DeviceUtils.getScaledHeight(context, scale: 0.01),
          ),
          Center(
            child: Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: AppColors.appPrimaryColor,
                  fontFamily: 'Montserrat ExtraBold'),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: DeviceUtils.getScaledHeight(context, scale: 0.02),
          ),
          Text(
            subText,
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 13,
                fontFamily: 'Montserrat Regular'),
            textAlign: TextAlign.center,
          )
        ],
      ));
}
