import 'package:flutter/material.dart';
import 'package:yuga_portfolio/widgets/responsive.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      mobile: _buildMobileNavbar(),
      desktop: _buildDesktopNavbar(context),
    );
  }

  Widget _buildMobileNavbar() {
    return AppBar(
      backgroundColor: Colors.black,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {
          
        },
      ),
    );
  }

  Widget _buildDesktopNavbar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 60.0),
      child: Container(
        width: double.infinity, // Ensures full-width navbar
        height: MediaQuery.of(context).size.height * 0.09,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.black,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
            children: [
              _buildNavbarItem("Home", true),
              _buildNavbarItem("About", false),
              _buildNavbarItem("Service", false),
              _buildNavbarItem("Resume", false),
              _buildNavbarItem("Porfile", false),
              _buildNavbarItem("Contact", false),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavbarItem(String title, bool isActive) {
    return MouseRegion(
      child: StatefulBuilder(
        builder: (context, setState) {
          bool isHovered = false;
          return MouseRegion(
            onEnter: (_) => setState(() => isHovered = true),
            onExit: (_) => setState(() => isHovered = false),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              decoration: BoxDecoration(
                color: isHovered || isActive ? Color(0xFFFD853A) : Colors.black,
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextButton(
                onPressed: () {
                  
                },
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
