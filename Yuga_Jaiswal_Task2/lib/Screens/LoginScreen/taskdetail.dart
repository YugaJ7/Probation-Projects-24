import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/Components/task.dart';
import 'package:todo_app/Components/text.dart';

class TaskDetailScreen extends StatefulWidget {
  final Task task;
  final VoidCallback onComplete;
  final VoidCallback onDelete;

  TaskDetailScreen({required this.task, required this.onComplete, required this.onDelete});

  @override
  _TaskDetailScreenState createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text(
        //   widget.task.title,
        //   style: GoogleFonts.gowunDodum(
        //     textStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        //   ),
        // ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: widget.onDelete
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: widget.onDelete,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                widget.task.title,
                style: GoogleFonts.gowunDodum(
                  textStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w700,fontSize: 40),
                )),
            SizedBox(height: 8),
            Row(
              children: [
                _buildLabel(widget.task.priority, widget.task.priorityColor),
              ],
            ),
            SizedBox(height: 16),
            Text(widget.task.description, style: TextStyle(fontSize: 16)),
            SizedBox(height: 16),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                              text: "Due Date",
                              fontStyle: null,
                              color: Colors.grey[600],
                              fontweigth: null,
                              fontSize: 16,
                            ),
                            SizedBox(height: 8,),
                          Row(children: [Icon(Icons.calendar_month_rounded, size: 19), SizedBox(width: 5),Text(widget.task.dueDate,style:TextStyle(fontSize: 15),),],)
                        ],
                      ),
                      
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                              text: "End Time",
                              fontStyle: null,
                              color: Colors.grey[600],
                              fontweigth: null,
                              fontSize: 16,
                            ),
                            SizedBox(height: 8,),
                          Row(children: [Icon(FontAwesomeIcons.clock, size: 19), SizedBox(width: 5),Text(widget.task.time,style:TextStyle(fontSize: 15),),],)
                        ],
                      ),
                      
                    ],
                  ),
                ],
              ),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: widget.onComplete,
                  style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  'Mark as Completed',
                  style: TextStyle(fontSize: 18,color: Colors.white),
                ),
            ),
            )
            
            
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontSize: 12),
      ),
    );
  }
}
