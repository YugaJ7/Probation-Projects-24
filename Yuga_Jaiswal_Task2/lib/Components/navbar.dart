import 'package:flutter/material.dart';
import 'package:todo_app/Screens/calender.dart';
import 'package:todo_app/Screens/create.dart';
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
      ProfileScreen(),
    ];
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Stack(
        clipBehavior: Clip.none,
        children: [
          BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap:(int index) {
                if (index == 2) { 
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreateTask()),
                  );
                } else if (index == 3) { 
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchPage()),
                  );
                } else {
                  setState(() {
                    _selectedIndex = index;
                  });
                }
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
          Positioned(
            top: -30,  
            left: MediaQuery.of(context).size.width / 2 - 30,
            child:SizedBox(
                width: 60,
                height: 60,
                child: FittedBox(
                  child: FloatingActionButton(
                  onPressed:() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CreateTask()),
                        );
                    },
                    backgroundColor: Colors.blue,
                    shape: CircleBorder(),
                    child: const Icon(Icons.edit, color: Colors.white),
                    elevation: 5,
                  ),
                ),
              )
            )
        ],
      ),
    );
  }
}




