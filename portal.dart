import 'package:eatsmart/Widget/background.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:eatsmart/Screens/Login/Components/login_body.dart';

class PortalScreen extends StatefulWidget {
  const PortalScreen({super.key});

  @override
  State<PortalScreen> createState() => _PortalScreenState();
}

class _PortalScreenState extends State<PortalScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  late AnimationController _downController;
  late Animation<double> _downAnimation;

  bool _isNavigating = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _downController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _downAnimation = CurvedAnimation(
      parent: _downController,
      curve: Curves.easeIn,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _downController.dispose();
    super.dispose();
  }

  void _onButtonPressed(VoidCallback onPressedAction) {
    if (!_isNavigating) {
      setState(() {
        _isNavigating = true;
      });

      _downController.forward().then((_) {
        onPressedAction();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedBuilder(
                animation: _isNavigating ? _downAnimation : _animation,
                builder: (context, child) {
                  double offset = MediaQuery.of(context).size.height * (1 - (_isNavigating ? _downAnimation.value : _animation.value));
                  
                  return Transform.translate(
                    offset: Offset(0, offset),
                    child: Container(
                      height: 250,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: HexColor("#dad8cc"),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        _onButtonPressed(() {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) => const LoginBodyScreen(),
                                            ),
                                          );
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                                                                backgroundColor: HexColor("#f0f3f1"),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                        padding: const EdgeInsets.symmetric(vertical: 20),
                                        side: BorderSide(color: HexColor("#4f4f4f")),
                                      ),
                                      child: Text(
                                        "Get Started",
                                        style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          color: HexColor("#4f4f4f"),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        _onButtonPressed(() {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) => const LoginBodyScreen(),
                                            ),
                                          );
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: HexColor("#dad8cc"),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                        padding: const EdgeInsets.symmetric(vertical: 20),
                                        side: BorderSide(color: HexColor("#4f4f4f")),
                                      ),
                                      child: Text(
                                        "I already have an account",
                                        style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          color: HexColor("#4f4f4f"),
                                        ),
                                      ),
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
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}