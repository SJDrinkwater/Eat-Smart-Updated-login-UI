import 'package:eatsmart/Components/my_textfield.dart';
import 'package:eatsmart/Screens/Login/login.dart';
import 'package:eatsmart/Widget/background.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class LoginBodyScreen extends StatefulWidget {
  const LoginBodyScreen({super.key});

  @override
  State<LoginBodyScreen> createState() => _LoginBodyScreenState();
}

class _LoginBodyScreenState extends State<LoginBodyScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String _errorMessage = "";

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

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void validateEmail(String val) {
    if (val.isEmpty) {
      setState(() {
        _errorMessage = "Email tidak boleh kosong";
      });
    } else if (!EmailValidator.validate(val, true)) {
      setState(() {
        _errorMessage = "Alamat Email tidak valid";
      });
    } else {
      setState(() {
        _errorMessage = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, MediaQuery.of(context).size.height * (1 - _animation.value)),
                child: Container(
                  height: 425,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: HexColor("#dad8cc"), // Background color
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
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 0, 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              MyTextField(
                                onChanged: () {
                                  validateEmail(emailController.text);
                                },
                                controller: emailController,
                                hintText: "Email",
                                obscureText: false,
                                prefixIcon: const Icon(Icons.mail_outline),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                child: Text(
                                  _errorMessage,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              MyTextField(
                                controller: passwordController,
                                hintText: "**************",
                                obscureText: true,
                                prefixIcon: const Icon(Icons.lock_outline),
                              ),
                              const SizedBox(height: 20),
                              // Forgot Password button
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 30, 20),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => const LoginScreen(), // Replace with your LoginScreen widget
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Forgot Password",
                                      style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        color: HexColor("#8d8d8d"),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Handle login action here
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
                                    "Login",
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
      ),
    );
  }
}