import 'package:flutter/material.dart';
import 'package:flutter_application_4/Auth/Login/login.dart';
import 'package:flutter_application_4/onboarding/intro_screen1.dart';
import 'package:flutter_application_4/onboarding/intro_screen2.dart';
import 'package:flutter_application_4/onboarding/intro_screen3.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Introduction extends StatefulWidget {
  const Introduction({Key? key}) : super(key: key);

  @override
  State<Introduction> createState() => _IntroductionState();
}

class _IntroductionState extends State<Introduction> {
  final PageController _controller = PageController();
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });
            },
            children: const [
              IntroPage2(),
              IntroPage1(),
              IntroPage3(),
            ],
          ),
          Align(
            alignment: const Alignment(0, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    _controller.jumpToPage(2); // Jump to the last page
                  },
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Salsa',
                      color: Colors.white,
                    ),
                  ),
                ),
                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                ),
                onLastPage
                    ? GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return const Center(child: CircularProgressIndicator());
                            },
                          );

                          Future.delayed(const Duration(seconds: 2), () {
                            Navigator.of(context)
                                .pop(); // Close the loading dialog
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return const Login(); // Navigate to the Signup page
                                },
                              ),
                            );
                          });
                        },
                        child: const Text(
                          'Done',
                          style: TextStyle(
                            fontSize: 30,
                            fontFamily: 'Salsa',
                            color: Colors.white,
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          _controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                          );
                        },
                        child: const Text(
                          'Next',
                          style: TextStyle(
                            fontSize: 30,
                            fontFamily: 'Salsa',
                            color: Colors.white,
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
