import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class ProfileScreen extends StatefulWidget {
  final String username;

  ProfileScreen({required this.username});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, int>> fetchHighscores() async {
    final uid = _auth.currentUser?.uid;
    if (uid != null) {
      final highScoresSnapshot = await _firestore
          .collection('users')
          .doc(uid)
          .collection('high_scores')
          .get();

      Map<String, int> categoryScores = {};

      for (var doc in highScoresSnapshot.docs) {
        final category = doc.id; 
        final score = doc.data()['score'] ?? 0;
        categoryScores[category] = score;
      }
      return categoryScores;
    }
    return {}; 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF6A5AE0),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/splash_back.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height*.05,
            left: MediaQuery.of(context).size.width*.01,
            child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.grey,size: 30,),
                onPressed: () {
                   Navigator.pop(context);
                },
              ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/trophy.json', 
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  repeat: true,
                ),
                Text(
                  widget.username,
                  style: GoogleFonts.mulish(
                    textStyle: TextStyle(
                      color: Color(0xFFF5DEB3),
                      fontWeight: FontWeight.w600,
                      fontSize: 45,
                    ),
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                SizedBox(height: 10),
                Text(
                  "Your High Scores",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: FutureBuilder<Map<String, int>>(
                      future: fetchHighscores(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return Center(
                            child: Text(
                              'Leaderboard is waiting for your score',
                              style: GoogleFonts.mulish(
                                textStyle: TextStyle(
                                  color: Color(0xFF6A5AE0),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        } else {
                          return ListView.builder(
                            itemCount: snapshot.data!.keys.length,
                            itemBuilder: (context, index) {
                              String category = snapshot.data!.keys.elementAt(index);
                              int score = snapshot.data![category]!;

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    category,
                                    style: GoogleFonts.mulish(
                                      textStyle: TextStyle(
                                        color: Color(0xFF6A5AE0),
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    leading: Icon(
                                      Icons.star,
                                      color: Color(0xFF7B6DE4),
                                    ),
                                    title: Text(
                                      'Score: $score',
                                      style: GoogleFonts.mulish(
                                        textStyle: TextStyle(
                                          color: Color(0xFF6A5AE0),
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                ],
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF7B6DE4),
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      'Sign Out',
                      style: GoogleFonts.mulish(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
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
