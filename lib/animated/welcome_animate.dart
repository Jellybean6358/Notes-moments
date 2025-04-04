import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/homepage.dart';

class WelcomeAnimateScreen extends StatefulWidget {
  const WelcomeAnimateScreen({super.key});

  @override
  WelcomeAnimateScreenState createState() => WelcomeAnimateScreenState();
}

class WelcomeAnimateScreenState extends State<WelcomeAnimateScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _welcomeSlideUpAnimation;
  late Animation<double> _welcomeFadeOutAnimation;
  late Animation<double> _welcomeFadeInAnimation;
  late Animation<double> _glitterAnimation;
  late Animation<Offset> _homeSlideUpAnimation;
  late Animation<double> _homeFadeInAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    // Welcome Text Animations
    _welcomeSlideUpAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _welcomeFadeOutAnimation = Tween<double>(
      begin: 10.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.5, curve: Curves.easeInOut),
      ),
    );

    _welcomeFadeInAnimation = Tween<double>(
      begin: 0.0,
      end: 5.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeInOut),
      ),
    );

    _glitterAnimation = Tween<double>(
      begin: 0.0,
      end: 3.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn,
      ),
    );
    // Home Screen Animations
    _homeSlideUpAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
        // begin: 0.5, // Start home animation halfway through welcome animation
        // end: 1.0,
      ),
    );

    _homeFadeInAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeInOut),
      ),
    );

    _controller.forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {}
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Welcome Text Animations
          SlideTransition(
            position: _welcomeSlideUpAnimation,
            child: FadeTransition(
              opacity: _welcomeFadeOutAnimation,
              child: AnimatedBuilder(
                animation: _glitterAnimation,
                builder: (context, child) {
                  return ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        colors: [
                          Colors.pinkAccent,
                          Colors.white,
                          Colors.blueAccent,
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        stops: [
                          _glitterAnimation.value - 0.5,
                          _glitterAnimation.value,
                          _glitterAnimation.value + 0.5
                        ],

                      ).createShader(bounds);
                    },
                    blendMode: BlendMode.srcIn,
                    child: child,
                  );
                },
                child: const Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 50.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Pacifica',
                    //color:Colors.amber,
                  ),
                ),
              ),
            ),
          ),
          SlideTransition(
            position: _welcomeSlideUpAnimation,
            child: FadeTransition(
              opacity: _welcomeFadeInAnimation,
              child: Text(
                'To Your Journal',
                style: TextStyle(
                  fontSize: 50.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Pacifica',
                ),
              ),
            ),
          ),

          // Home Screen Animation
          SlideTransition(
            position: _homeSlideUpAnimation,
            child: FadeTransition(
              opacity: _homeFadeInAnimation,
              child: Homepage(), // Replace with your actual HomeScreen widget
            ),
          ),
        ],
      ),
    );
  }
}
