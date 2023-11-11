// ignore_for_file: use_build_context_synchronously
import 'package:assignment/constant/color.dart';
import 'package:assignment/constant/image.dart';
import 'package:assignment/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

TextEditingController _mobileController = TextEditingController();
TextEditingController _otpController = TextEditingController();

FirebaseAuth _auth = FirebaseAuth.instance;
User? user;
UserCredential? credential;
String phoneNumber = "";
String code = "";

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    Future<void> signInWithMobile() async {
      await _auth.verifyPhoneNumber(
        phoneNumber: _mobileController.text,
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          await _auth.signInWithCredential(phoneAuthCredential).then(
            (value) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            },
          );
        },
        verificationFailed: ((error) {
          print(error.message.toString());
        }),
        codeSent: (String verificationId, [int? forceResendingToken]) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Enter OTP"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _otpController,
                  )
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    FirebaseAuth auth = FirebaseAuth.instance;
                    code = _otpController.text;
                    PhoneAuthCredential credential =
                        PhoneAuthProvider.credential(
                      verificationId: verificationId,
                      smsCode: code,
                    );
                    auth.signInWithCredential(credential).then((value) {
                      if (value != null) {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                        ).catchError((onError) {
                          print(onError.toString());
                        });
                      }
                    });
                  },
                  child: const Text("Send"),
                ),
              ],
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          verificationId = verificationId;
        },
        timeout: const Duration(seconds: 60),
      );
    }

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
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    },
                    child: Text(
                      "SKIP",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: red,
                        decoration: TextDecoration.underline,
                      ),
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
                              onChanged: (value) {
                                phoneNumber = value;
                              },
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
                                onPressed: () {
                                  signInWithMobile();
                                },
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
