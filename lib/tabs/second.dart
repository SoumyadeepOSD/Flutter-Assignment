import 'package:flutter/material.dart';
import '../constant/image.dart';
import 'first.dart';

class Second extends StatefulWidget {
  const Second({super.key});

  @override
  State<Second> createState() => _SecondState();
}

class _SecondState extends State<Second> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              const SizedBox(height: 30.0),
              const Text(
                "Category",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  category(haircut, "Hair Cut"),
                  category(makeup, "Makeup"),
                  category(straight, "Straightening"),
                ],
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  category(nail, "Mani-pedi"),
                  category(spa, "Spa/Message"),
                  category(beard, "Beard"),
                ],
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  category(haircolor, "Hair Coloring"),
                  category(waxing, "Waxing"),
                  category(facial, "Facial"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
