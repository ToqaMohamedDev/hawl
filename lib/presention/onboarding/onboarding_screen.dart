import 'package:flutter/material.dart';
import 'package:untitled/presention/customs/custom_text.dart';
import 'package:untitled/presention/resorces/routes_manager.dart';
import '../../model/DataModel.dart';
import '../resorces/color_app.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}
class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.whiteColor,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (int index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemCount: OnBoardingList.length,
              itemBuilder: (BuildContext context, int index) {
                return Center(
                  child: Container(
                    width: 250,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Center(
                          child: Container(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            height: 250,
                            width: 250,
                            child: Image.asset(
                              OnBoardingList[index]['image'],
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 25.0),
                          child: Center(
                            child: CustomText(
                              name: OnBoardingList[index]['text'],
                              maxLines: 5,
                              textAlign: TextAlign.center,
                              fontWeight: FontWeight.w700,
                              font: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                OnBoardingList.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  height: 10.0,
                  width: _currentIndex == index ? 12.0 : 8.0,
                  decoration: BoxDecoration(
                    color: _currentIndex == index ? ColorManager.appbarColor : Colors.grey,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: ElevatedButton(
              onPressed: () {
                if (_currentIndex == OnBoardingList.length - 1) {
                  Navigator.pushNamed(context, Routes.loginRoute);
                } else {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.appbarColor,
                padding: const EdgeInsets.symmetric(
                    horizontal: 32.0, vertical: 12.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: CustomText(name:   _currentIndex == OnBoardingList.length - 1 ? "تخطي" : "التالي", fontWeight: FontWeight.w600
                  , font: 14,color: ColorManager.whiteColor,),
            ),
          ),
        ],
      ),
    );
  }
}
