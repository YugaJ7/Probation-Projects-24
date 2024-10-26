import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/Components/task.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  final String username;
  HomeScreen({required this.username});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> tasks = [];

  void _addNewTask(Task task) {
    setState(() {
      tasks.add(task);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 330,
                width: double.infinity,
                color: Color.fromARGB(255, 29, 78, 216),
              ),
              Positioned(
                top: 60,
                left: 20,
                right: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Hello ${widget.username}',
                          style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600)),
                        ),
                        Icon(Icons.notifications, color: Colors.white, size: 30),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Today is ${DateFormat('EEEE, MMMM d').format(DateTime.now())}', 
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600)),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      height: 170,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          return TaskCard(
                            title: tasks[index].title,
                            description: tasks[index].description,
                            priority: tasks[index].priority,
                            dueDate: tasks[index].dueDate,
                            time: tasks[index].time,
                            priorityColor: tasks[index].priorityColor,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  final String title;
  final String description;
  final String priority;
  final String dueDate;
  final String time;
  final Color priorityColor;

  TaskCard({
    required this.title,
    required this.description,
    required this.priority,
    required this.dueDate,
    required this.time,
    required this.priorityColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330,
      child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: priorityColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: priorityColor)
              ),
              child: Text(
                priority,
                style: TextStyle(
                  color: priorityColor,
                  fontSize: 12,
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [Icon(Icons.calendar_month_rounded),SizedBox(width: 5,),Text(dueDate)],),
                Row(children: [Icon(FontAwesomeIcons.clock),SizedBox(width: 5,),Text(time)],)                                

              ],
            ),
          ],
        ),
      ),
    )
    );
  }
}
