import 'package:flutter/material.dart';

class Task {
  final String title;
  final String description;
  final String priority;
  final String dueDate;
  final String time;
  final Color priorityColor;

  Task({
    required this.title,
    required this.description,
    required this.priority,
    required this.dueDate,
    required this.time,
    required this.priorityColor,
  });
}
