import 'package:flutter/material.dart';
import 'package:gypsy/screen/splash/splash/onboarding/flutter_slider.dart';
import 'package:gypsy/screen/splash/splash/onboarding/onboardingmodels.dart';
import 'package:gypsy/screen/splash/splash/starter/starter_page.dart';


class OnbaordingScreen extends StatefulWidget {
  const OnbaordingScreen({Key? key}) : super(key: key);
  static const String route ="onboarding";


  @override
  State<OnbaordingScreen> createState() => _OnbaordingScreenState();
}

class _OnbaordingScreenState extends State<OnbaordingScreen> {
  late PageController _controller;

  final List<onboardingModel> _data = onboardingModel.data;
  int _activeIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
    _controller.addListener(() {
      setState(() {
        _activeIndex = _controller.page!.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: _data.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    const SizedBox(height: 72),
                    Image.asset(_data[index].imagePath!, width: 550),
                  ],
                );
              },
            ),
          ),
          SliderIndicator(
            length: _data.length,
            activeIndex: _activeIndex,
            indicator: const Icon(
              Icons.fiber_manual_record_rounded,
              color: Color(0XFFF2f2f2),
              size: 15,
            ),
            activeIndicator: const Icon(
              Icons.fiber_manual_record_rounded,
              color: Color(0XFFFC6011),
              size: 15,
            ),
          ),
          const SizedBox(height: 40),
          SizedBox(
            height: 50,
            child: Text(
              _data[_activeIndex].title!,
              style: Theme.of(context).textTheme.headline5!.copyWith(
                    color: const Color(0XFFFC6011),
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          SizedBox(
            height: 75,
            child: Text(
              _data[_activeIndex].desc!,
              style: Theme.of(context).textTheme.caption!.copyWith(
                    color: const Color(0XFF7C7D7E),
                    fontWeight: FontWeight.bold,
                    height: 1.6,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        if ((_activeIndex + 1) >= _data.length) {
                          Navigator.pushReplacementNamed(context, LoginRegisterScreen.route);
                          return;
                        }
                        _controller.animateToPage(
                          _activeIndex + 1,
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeIn,
                        );
                      },
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0XFFFC6011)),
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                                  const EdgeInsets.all(16))),
                      child: const Text('Next')),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
