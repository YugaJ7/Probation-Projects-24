import 'package:flutter/material.dart';
import 'package:yuga_portfolio/widgets/profile_photo.dart';
import 'package:yuga_portfolio/widgets/contact.dart';
import 'package:yuga_portfolio/widgets/navbar.dart';
import 'package:yuga_portfolio/widgets/profile.dart';
import 'package:yuga_portfolio/widgets/services.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Navbar(),
            ProfilePhoto(),
            MyServicesSection(),
            SizedBox(height: 30,),
            ProfileSection(),
            FooterSection()
          ],
        ),
      ),
    );
  }
}
