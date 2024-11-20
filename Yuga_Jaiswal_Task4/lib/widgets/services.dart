import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yuga_portfolio/widgets/mouse.dart';

class MyServicesSection extends StatelessWidget {
  const MyServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      child: Stack(
        children: [
          // Background Image
          Container(
            height: MediaQuery.of(context).size.height * 0.9,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('back.png'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(60, 70, 70, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "My Services",
                  style: TextStyle(
                    color: const Color(0xFFFD853A),
                    fontSize: screenWidth * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      OverlayAnimatedGridElement('assets/tile1.png'),
                      //OverlayAnimatedGridElement('assets/tile2.png'),
                    ],
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
