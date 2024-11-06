import 'package:confetti/confetti.dart';
import 'package:lottie/lottie.dart';
import 'dart:convert';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_app/screens/util.dart';
import 'package:quiz_app/services/api.dart';

class Quiz_Screen extends StatefulWidget {
  final String categoryName;

  Quiz_Screen({required this.categoryName});

  @override
  State<Quiz_Screen> createState() => _Quiz_ScreenState();
}

class _Quiz_ScreenState extends State<Quiz_Screen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

      String? question, answer;
      List<String> option=[];
      String? selectedOption;
      int score=0;
      final CountDownController _countDownController = CountDownController();
      final ConfettiController _controllerLeft = ConfettiController(duration: const Duration(seconds: 10));
      final ConfettiController _controllerRight = ConfettiController(duration: const Duration(seconds: 10));
      final int _duration =15;
      int highScore = 0;

    @override
    void initState(){
      super.initState();
      fetchQuiz(widget.categoryName);
      fetchHighScore();
    }

    Future<void> fetchHighScore() async {
      final uid = _auth.currentUser?.uid;
      final categoryDoc = await _firestore
          .collection('users')
          .doc(uid)
          .collection('high_scores')
          .doc(widget.categoryName)
          .get();

      setState(() {
        highScore = categoryDoc.data()?['score'] ?? 0;
      });
    }

    Future<void> fetchQuiz(String category)async{
      setState(() {
      question = null;
      answer = null;
      option.clear();
      selectedOption = null;
    });
      final response = await http.get(
        Uri.parse('https://api.api-ninjas.com/v1/trivia?category=$category'),
        headers: {
          'Content-Type':'application/json',
          'X-Api-Key': APIKEY,
        }
     );

      if(response.statusCode==200){
        List<dynamic> jsonData = jsonDecode(response.body);
        if(jsonData.isNotEmpty){
          Map<String, dynamic> quiz = jsonData[0];
          question = quiz["question"];
          answer = quiz["answer"];
          option.add(answer!);
          await RestOption();
          setState(() {
            option.shuffle();
          });
        }
      }
    }

    Future<void> RestOption() async{
      while (option.length < 4) { 
      final response = await http.get(
        Uri.parse('https://api.api-ninjas.com/v1/randomword'),
        headers: {
          'Content-Type': 'application/json',
          'X-Api-Key': APIKEY,
        },
      );

      if(response.statusCode==200){
        Map<String, dynamic> jsonData = jsonDecode(response.body);
        if(jsonData.isNotEmpty){
          String word = jsonData["word"].toString(); 
          if (!option.contains(word)) { 
            option.add(word);
          }
        }
      } 
    }
  }

Future<void> checkAnswer(String selectedAnswer) async {
  _countDownController.pause();
    setState(() {
      selectedOption = selectedAnswer;
    });

    if (selectedAnswer == answer) {
      score=score+10;
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          backgroundColor: Colors.green[100],
          content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              'assets/correct.json', 
              width: 100,
              height: 100,
              repeat: true, 

            ),
            Text(
              "Correct!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green[800],
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Good job! You got the right answer.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.green[700],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width*.9,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[200],
                  elevation: 10,
                  shadowColor: Colors.green
                ),
              child: Text(
                "Next Question",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.green[800],
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                fetchQuiz(widget.categoryName); 
              },
             ),
            ),
          ],
        ),
      )
    );
    } else if(highScore<score){
      await updateHighScoreIfNeeded();
    }
    else{
        showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          backgroundColor: Colors.red[50],
          content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              'assets/wrong.json', 
              width: 100,
              height: 100,
              repeat: true,
            ),
            SizedBox(height: 20),
            Text(
              "Oops! Wrong Answer",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.red[800],
              ),
            ),
            SizedBox(height: 10),
            Text(
              "'The correct answer was $answer.\nYour score: $score",
              style: TextStyle(
                fontSize: 16,
                color: Colors.red[700],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width*.9,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[200],
                  elevation: 10,
                  shadowColor: Colors.red
                ),
              child: Text(
                "Try Again",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.red[700],
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
             ),
            )
          ],
        ) 
       ),
      );
    }
  }

  Future<void> updateHighScoreIfNeeded() async {
    setState(() {
      highScore = score;
      });
    _controllerRight.play();
    _controllerLeft.play();
    final uid = _auth.currentUser?.uid;
    await _firestore
        .collection('users')
        .doc(uid)
        .collection('high_scores')
        .doc(widget.categoryName)
        .set({'score': score});

     showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: ConfettiWidget(
                confettiController: _controllerRight,
                blastDirectionality: BlastDirectionality.explosive,
                emissionFrequency: 0.05,
                numberOfParticles: 100,
                gravity: 1.0,
                colors: [Colors.blue, Colors.pink, Colors.orange, Colors.purple],
                createParticlePath: drawStar,
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: ConfettiWidget(
                confettiController: _controllerLeft,
                blastDirectionality: BlastDirectionality.explosive,
                emissionFrequency: 0.05,
                numberOfParticles: 150,
                gravity: 1.0,
                colors: [Colors.blue, Colors.pink, Colors.orange, Colors.purple],
                createParticlePath: drawStar,
              ),
            ),       
            AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
              ),
              backgroundColor: Colors.blue[50],
              content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset(
                  'assets/party_popper.json', 
                  width: 150,
                  height: 150,
                  repeat: true, 
                ),
                Text(
                  "New High Score!",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[800],
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Congratulations! You've set a new high score of $highScore score!",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue[700],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width*.9,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[200],
                      elevation: 10,
                      shadowColor: Colors.blue
                    ),
                  child: Text(
                    "Continue",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.blue[700],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
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
@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: option.length!=4?Center(child: CircularProgressIndicator(),):Container(
      child: Stack(
        children: [
          Container(
                  height: MediaQuery.of(context).size.height,
                  width:  MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/quiz_back.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
            ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 70),
              Container(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 56, 124, 225),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      widget.categoryName.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
              const SizedBox(height: 20),
              CircularCountDownTimer(
                      duration: _duration,
                      initialDuration: 0,
                      controller: _countDownController,
                      width: 80,
                      height: 80,
                      ringColor: Colors.transparent,
                      fillColor: Color.fromARGB(255, 44, 88, 168),
                      backgroundColor: Color(0xFF7097E0),
                      strokeWidth: 8.0,
                      strokeCap: StrokeCap.round,
                      textStyle: const TextStyle(
                        fontSize: 35.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      isReverse: true,
                      onComplete: () async {
                        if(highScore<score){
                          await updateHighScoreIfNeeded();
                        }else {
                          showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) => AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            backgroundColor: Colors.orange[50],
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Lottie.asset(
                                  'assets/time_up.json',
                                  width: 200,
                                  height: 200,
                                  repeat: true,
                                ),
                                SizedBox(height: 20),
                                Text(
                                  "Time's Up!",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange[800],
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "The correct answer was $answer.\nYour score: $score",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.orange[700],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 10),
                                Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width*.9,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.orange[200],
                                      elevation: 10,
                                      shadowColor: Colors.orange
                                    ),
                                  child: Text(
                                    "Try Again",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.orange[700],
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).popUntil((route) => route.isFirst);
                                  },
                                ),
                                )
                              ],
                            ),
                          ),
                        );
                        }
                      },
                    ),
              const SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    const SizedBox(height: 10,),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Color(0xFFFF8FA2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'YOUR SCORE',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Color(0xFFBA6060),
                              shape: BoxShape.circle,
                             ),
                            child: Text(
                              '$score',
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      child: Text(
                      question!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    ),
                    const SizedBox(height: 10),
                    for (var option in option)
                            GestureDetector(
                              onTap: () => checkAnswer(option),
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: selectedOption == option
                                      ? (option == answer ? Colors.green : Colors.red)
                                      : Color(0xFF4471C3),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Text(
                                  option.replaceAll(RegExp(r'[\[\]]'), "").substring(0, 1).toUpperCase() + option.replaceAll(RegExp(r'[\[\]]'), "").substring(1).toLowerCase(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    )
    );
  }
}