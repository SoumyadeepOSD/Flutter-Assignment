import 'package:assignment/constant/color.dart';
import 'package:assignment/constant/image.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

TextEditingController _mobileController = TextEditingController();
FirebaseAuth _auth = FirebaseAuth.instance;

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(children: [
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(height: 0.0),
                  Text(
                    "SKIP",
                    style: TextStyle(
                      fontSize: 14.0,
                      color: red,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: Stack(
                  children: <Widget>[
                    const Image(
                      height: 350,
                      width: 350,
                      fit: BoxFit.fitHeight,
                      image: AssetImage(
                        onboardingImage,
                      ),
                    ),
                    Positioned(
                      top: 370,
                      left: 150,
                      child: Container(
                        height: 60,
                        width: 70,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(50.0),
                          ),
                        ),
                        child: const Image(
                          height: 20,
                          width: 20,
                          image: AssetImage(enteruserImage),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 400,
                      bottom: 100, // to shift little up
                      left: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: lightGrey,
                            width: 1.0,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: [
                            const SizedBox(height: 70.0),
                            TextField(
                              decoration: InputDecoration(
                                hintText: "Enter Mobile Number",
                                hintStyle: TextStyle(
                                  color: grey,
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: lightGrey,
                                  ),
                                ),
                              ),
                              controller: _mobileController,
                              keyboardType: TextInputType.number,
                            ),
                            const SizedBox(height: 50.0),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20.0),
                                  backgroundColor: darkBlue,
                                  elevation: 0.0,
                                ),
                                onPressed: () {},
                                child: Text(
                                  "CONTINUE",
                                  style:
                                      TextStyle(color: white, fontSize: 16.0),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            const Text(
                              "By Continuing you are agree to our",
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Terms & Conditions ",
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: darkBlue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: "and ",
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "Privacy Policy",
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: darkBlue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

// // *Function to handle mobile auth*
// Future<void> verifyPhoneNumber(String mobile) async {
//   final PhoneVerificationCompleted verificationCompleted =
//       (PhoneAuthCredential credential) async {
//     await _auth.signInWithCredential(credential);
//   };
//   final PhoneVerificationFailed verificationFailed = (FirebaseException e) {
//     if (e.code == 'invalid-phone-number') {
//       print('The provided phone number is not valid.');
//     } else {
//       print(e.message);
//     }
//   };
// }
