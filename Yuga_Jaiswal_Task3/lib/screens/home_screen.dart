import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_app/screens/profile.dart';
import 'package:quiz_app/screens/quiz_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String username = 'Loading...';

  final List<String> categories = ["Mathematics","General","Language","Geography","Music","Entertainment"];
  IconData getCategoryIcon(int index) {
  switch (index) {
    case 0:
      return FontAwesomeIcons.squareRootVariable;
    case 1:
      return FontAwesomeIcons.graduationCap;
    case 2:
      return FontAwesomeIcons.language;
    case 3:
      return FontAwesomeIcons.earthAsia;
    case 4:
      return FontAwesomeIcons.music;
    case 5:
      return FontAwesomeIcons.clapperboard;
    default:
      return Icons.quiz;
  }
}


  @override
  void initState() {
    super.initState();
    fetchUsername();
  }

  Future<void> fetchUsername() async {
    final uid = _auth.currentUser?.uid;
    if (uid != null) {
      final userDoc = await _firestore.collection('users').doc(uid).get();
      setState(() {
        username = userDoc.data()?['username'] ?? 'Unknown User';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF6A5AE0),
        body: Stack(
          children: [
            Container(
                height: MediaQuery.of(context).size.height,
                width:  MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/splash_back.png'),
                    fit: BoxFit.cover,
                  ),
                ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          "Welcome, $username",
                          style: GoogleFonts.mulish(
                            textStyle: TextStyle(
                              color: Color(0xFFF5DEB3),
                              fontWeight: FontWeight.w600,
                              fontSize: 45
                            )
                          ),
                         overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      IconButton(
                        icon: Icon(FontAwesomeIcons.solidCircleUser, color: Color(0xFF6A5AE0), size: 50,),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfileScreen(username: username),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Select Your Category",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: MediaQuery.of(context).size.height*0.65,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)
                    ),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2.2 / 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 20,
                      ),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Quiz_Screen(categoryName: categories[index]),
                                ),
                              );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFE7E4FA),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 65,
                                  width: 65,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white
                                  ),
                                  child: Icon(
                                    getCategoryIcon(index), 
                                    color: Color(0xFF6A5AE0),
                                    size: 40,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  categories[index],
                                  style: GoogleFonts.mulish(
                                    textStyle: TextStyle(
                                      color: Color(0xFF7B6DE4),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )]
                              )
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
    );
  }
}
