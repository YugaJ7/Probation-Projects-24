import 'package:flutter/material.dart';

class Quiz_Screen extends StatefulWidget {
  final String categoryName;

  Quiz_Screen({required this.categoryName});

  @override
  State<Quiz_Screen> createState() => _Quiz_ScreenState();
}

class _Quiz_ScreenState extends State<Quiz_Screen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
                height: MediaQuery.of(context).size.height,
                width:  MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/splash_back.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
          ),
      ],
    );
  }
}