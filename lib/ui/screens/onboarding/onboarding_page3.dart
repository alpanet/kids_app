import 'package:flutter/material.dart';
import 'package:kids_app/theme.dart';
class OnboardingPage3 extends StatelessWidget {
  final int currentPage;
  final PageController pageController;

  const OnboardingPage3({super.key, required this.currentPage, required this.pageController});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.onboardingPageTreeColorStart, AppTheme.onboardingPageTreeColorEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 20.0),
            ),
            Text(
              'Kontrol Tam Sizde!',
              style: AppTheme.onboardingTitle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              'Ekran süresini istediğiniz gibi ayarlayarak, çocuklarınızın günlük dijital zamanı üzerinde tamamen kontrol sahibi olun.',
              style: AppTheme.onboardingSubTitle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),
            Center(
              child: Transform.rotate(
                angle: 0,
                child: Container(
                  width: screenWidth * 0.9,
                  height: screenWidth * 0.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Image.asset(
                    'assets/onboarding_images/onboarding_tree.webp',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 20.0,
                  height: 20.0,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentPage == index ? Colors.white : Colors.grey,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height *
                    0.07,
              ),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors
                        .transparent,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2.0,
                    ),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () {
                      if (currentPage < 3) {
                        pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                      }
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
