import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_app/screens/quiz_screen.dart';
import 'package:quiz_app/screens/util.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String username = '';

  final List<String> categories = [
  "Mathematics",
  "General",
  "Language",
  "Geography",
  "Music",
  "Entertainment"
];

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
          SingleChildScrollView(
            child: Padding(
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
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              color: Color(0xFFF5DEB3),
                              fontWeight: FontWeight.bold,
                              fontSize: 40
                            )
                          ),
                         overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.logout, color: Colors.grey),
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Select Your Category",
                    style: TextStyle(
                      color: Color(0xDDE3A55E),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GridView.builder(
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
                            color: Color(0xDDD3D3D3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              categories[index],
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                )
                              ),
                          ),
                        )),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      );
  }
}
