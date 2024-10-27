import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/Components/task.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/Screens/LoginScreen/taskdetail.dart';
import 'package:todo_app/Screens/create.dart';

class HomeScreen extends StatefulWidget {
  final String username;
  HomeScreen({required this.username});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  List<Task> tasks = [];
  List<Task> completedTasks = [];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _addNewTask(Task task) {
    setState(() {
      tasks.add(task);
    });
  }
  void _markTaskAsComplete(Task task) {
    setState(() {
      tasks.remove(task);
      completedTasks.add(task);
    });
  }

  void _deleteTask(Task task, {bool fromCompleted = false}) {
    setState(() {
      if (fromCompleted) {
      completedTasks.remove(task); 
    } else {
      tasks.remove(task); 
    }
    });
  }

  void _updateTask(Task updatedTask) {
  setState(() {
    int index = tasks.indexWhere((task) => task.title == updatedTask.title && task.dueDate == updatedTask.dueDate);
    if (index != -1) {
      tasks[index] = updatedTask;
    }
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
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TaskDetailScreen(
                                    task: tasks[index],
                                    onComplete: () {
                                      _markTaskAsComplete(tasks[index]);
                                      Navigator.pop(context);
                                    },
                                    onDelete: () {
                                      _deleteTask(tasks[index], fromCompleted: false);
                                      Navigator.pop(context);
                                    },
                                    onUpdate: _updateTask
                                  ),
                                ),
                              );
                            },
                            child: TaskCard(
                              title: tasks[index].title,
                              description: tasks[index].description,
                              priority: tasks[index].priority,
                              dueDate: tasks[index].dueDate,
                              time: tasks[index].time,
                              priorityColor: tasks[index].priorityColor,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.blue,
              tabs: [
                Tab(text: "All Task"),
                Tab(text: "Complete"),
              ],
            ),
          ),
          Flexible(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildTaskList(tasks),
                _buildTaskList(completedTasks),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newTask = await Navigator.push<Task>(
            context,
            MaterialPageRoute(builder: (context) => CreateTask()),
          );
          if (newTask != null) {
            _addNewTask(newTask);
          }
        },
        shape: CircleBorder(),
        backgroundColor: Colors.blue,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildTaskList(List<Task> taskList) {
    return ListView.builder(
      itemCount: taskList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TaskDetailScreen(
                  task: taskList[index],
                  onComplete: () {
                    _markTaskAsComplete(taskList[index]);
                    Navigator.pop(context);
                  },
                  onDelete: () {
                    _deleteTask(taskList[index], fromCompleted: taskList == completedTasks);
                    Navigator.pop(context);
                  },
                  onUpdate: _updateTask
                ),
              ),
            );
          },
          child: TaskCard(
            title: taskList[index].title,
            description: taskList[index].description,
            priority: taskList[index].priority,
            dueDate: taskList[index].dueDate,
            time: taskList[index].time,
            priorityColor: taskList[index].priorityColor,
          ),
        );
      },
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
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      child: Card(
        elevation: 5,
        color: Colors.white,
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
                  border: Border.all(color: priorityColor),
                ),
                child: Text(
                  priority,
                  style: TextStyle(color: priorityColor, fontSize: 12),
                ),
              ),
              SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                description,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.calendar_month_rounded, size: 16),
                      SizedBox(width: 5),
                      Text(dueDate),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(FontAwesomeIcons.clock, size: 16),
                      SizedBox(width: 5),
                      Text(time),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
