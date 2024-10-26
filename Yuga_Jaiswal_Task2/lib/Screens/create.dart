import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/Components/task.dart';
import 'package:todo_app/Components/text.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({super.key});

  @override
  _CreateTaskState createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  DateTime? startDate;
  DateTime? endDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  String category = 'High';

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        if (isStartDate) {
          startDate = pickedDate;
        } else {
          endDate = pickedDate;
        }
      });
    }
  }

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        if (isStartTime) {
          startTime = pickedTime;
        } else {
          endTime = pickedTime;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add New Task',
          style: GoogleFonts.gowunDodum(
            textStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
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
              controller: titleController,
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
              controller: descriptionController,
              maxLines: 3,
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
            SizedBox(height: 20),
            
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => _selectDate(context, true),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Start Date',
                        suffixIcon: Icon(Icons.calendar_month_rounded),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.grey),
                            ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.grey),
                            )
                        ),
                      child: Text(startDate == null
                          ? 'Select Date'
                          : '${startDate!.toLocal()}'.split(' ')[0]), 
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _selectDate(context, false),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'End Date',
                        suffixIcon: Icon(Icons.calendar_month_rounded),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.grey),
                            ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.grey),
                            )
                        ),
                      child: Text(endDate == null
                          ? 'Select Date'
                          : '${endDate!.toLocal()}'.split(' ')[0]), 
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => _selectTime(context, true),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Start Time',
                        suffixIcon: Icon(FontAwesomeIcons.clock),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.grey),
                            ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.grey),
                            )
                        ),
                      child: Text(startTime == null
                          ? 'Select Time'
                          : startTime!.format(context)), 
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _selectTime(context, false),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Due Time',
                        suffixIcon: Icon(FontAwesomeIcons.clock),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.grey),
                            ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.grey),
                            )
                        ),
                      child: Text(endTime == null
                          ? 'Select Time'
                          : endTime!.format(context)),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: category,
              items: ['High', 'Medium', 'Normal'].map((String priority) {
                return DropdownMenuItem<String>(
                  value: priority,
                  child: Text(priority),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  category = value!;
                });
              },
              decoration: InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final newTask = Task(
                    title: titleController.text,
                    description: descriptionController.text,
                    priority: category,
                    dueDate: '${endDate!.toLocal()}'.split(' ')[0],
                    time: endTime!.format(context),
                    priorityColor: category == 'High'
                        ? Colors.redAccent
                        : category == 'Medium'
                            ? Colors.orangeAccent
                            : Colors.greenAccent,
                  );   
                  Navigator.pop(context, newTask);
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  'Create',
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