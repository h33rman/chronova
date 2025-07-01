// File: lib/screens/onboarding_screen.dart

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:chronova_app/config/app_router.dart';
import 'package:chronova_app/widgets/onboarding_page_template.dart'; // Import the template

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  bool _isLastPage = false; // To determine if "NEXT" or "GET STARTED" is shown

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                // Adjust this if you have more or fewer than 3 pages
                _isLastPage = (index == 2); // 0-indexed, so 2 is the 3rd page
              });
            },
            children: const [
              // Slide 1
              OnboardingPageTemplate(
                title: "Explore the Chornova Universe",
                description: "Embark on an epic journey through time and space, where every second counts. Discover new galaxies and unravel cosmic mysteries.",
                imagePath: 'assets/images/landing_img_01.png', // Uncomment and replace if you have a specific image
              ),
              // Slide 2
              OnboardingPageTemplate(
                title: "Compete Across Dimensions",
                description: "Challenge friends or conquer global leaderboards in thrilling real-time battles. Prove your mastery of time manipulation.",
                imagePath: 'assets/images/landing_img_02.png',
              ),
              // Slide 3
              OnboardingPageTemplate(
                title: "Forge Your Legacy",
                description: "Unlock powerful upgrades, customize your unique path to cosmic domination, and leave your mark on history.",
                imagePath: 'assets/images/landing_img_03.png',
              ),
            ],
          ),
          // Page Indicator and Buttons (positioned at the bottom)
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50.0, left: 24.0, right: 24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Keep column compact
                children: [
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: 3, // Total number of pages
                    effect: ExpandingDotsEffect(
                      activeDotColor: colorScheme.primary,
                      dotColor: colorScheme.primary.withValues(alpha: 0.3),
                      dotHeight: 8,
                      dotWidth: 8,
                      expansionFactor: 3,
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {
                        if (_isLastPage) {
                          // On the last page, navigate to login or home
                          appRouter.go('/home'); // Or '/home' if user is automatically logged in
                          // You might also set a flag here in SharedPreferences
                          // to prevent showing onboarding again
                        } else {
                          // Go to the next page
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeIn,
                          );
                        }
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        foregroundColor: colorScheme.onPrimary,
                      ),
                      child: Text(
                        _isLastPage ? "GET STARTED" : "NEXT",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  // Skip button, visible only on non-last pages
                  if (!_isLastPage)
                    TextButton(
                      onPressed: () {
                        appRouter.go('/home'); // Skip directly to login/registration
                        // Also set the SharedPreferences flag here if you're using it
                      },
                      child: Text(
                        "SKIP",
                        style: TextStyle(color: colorScheme.onSurface.withValues(alpha: 0.6)),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}