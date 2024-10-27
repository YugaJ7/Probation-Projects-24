// edit_task_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/Components/task.dart';
import 'package:todo_app/Components/text.dart';

class EditTaskScreen extends StatefulWidget {
  final Task task;

  EditTaskScreen({required this.task});

  @override
  _EditTaskScreenState createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late String _priority;
  late String _dueDate;
  late String _time;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _descriptionController = TextEditingController(text: widget.task.description);
    _priority = widget.task.priority;
    _dueDate = widget.task.dueDate;
    _time = widget.task.time;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveTask() {
    Task updatedTask = Task(
      title: _titleController.text,
      description: _descriptionController.text,
      priority: _priority,
      dueDate: _dueDate,
      time: _time,
      priorityColor: widget.task.priorityColor,
    );

    Navigator.pop(context, updatedTask);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Edit Task',
          style: GoogleFonts.gowunDodum(
            textStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomText(
              text: "Title",
              fontStyle: null,
              color: Colors.grey[600],
              fontweigth: null,
              fontSize: 16,
            ),
            SizedBox(height: 5),
            TextField(
              controller: _titleController,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                hintText: 'Title',
                hintStyle: TextStyle(color: Colors.grey),
                suffixIcon: Icon(Icons.edit),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 20),

            CustomText(
              text: "Description",
              fontStyle: null,
              color: Colors.grey[600],
              fontweigth: null,
              fontSize: 16,
            ),
            SizedBox(height: 5),
            TextField(
              controller: _descriptionController,
              maxLines: 2,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                hintText: 'Description',
                hintStyle: TextStyle(color: Colors.grey),
                suffixIcon: Icon(Icons.edit),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
            ),
            
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveTask,

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  'Save',
                  style: TextStyle(fontSize: 18,color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
