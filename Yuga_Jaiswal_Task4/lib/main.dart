import 'package:flutter/material.dart';
import 'package:yuga_portfolio/views/home_page.dart';

void main()
{
  return runApp(
    MaterialApp(
      //theme: ThemeData(primarySwatch: Colors.orange),
      debugShowCheckedModeBanner: false,
      initialRoute: '/dashboard',
      routes:
      {
        '/dashboard' : (context) => HomePage(),

      },
   )
  );
}