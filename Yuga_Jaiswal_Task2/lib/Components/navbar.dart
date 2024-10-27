import 'package:flutter/material.dart';
import 'package:todo_app/Screens/calender.dart';
import 'package:todo_app/Screens/home_screen.dart';
import 'package:todo_app/Screens/profile.dart';
import 'package:todo_app/Screens/search.dart';

class Navbar extends StatefulWidget {
  final String username;
  const Navbar({super.key,required this.username});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _selectedIndex = 0;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomeScreen(username: widget.username),  
      Calender(),
      SearchPage(),
      ProfileScreen()
    ];
  }
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap:(int index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                
              },
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today),
                label: 'Calendar',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
    );
  }
}




