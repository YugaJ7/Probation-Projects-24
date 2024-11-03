import 'package:flutter/material.dart';
import 'package:ecommerce_app/Screens/Notification.dart';
class Searchbar extends StatelessWidget implements PreferredSizeWidget{
  const Searchbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.white ,
        title: TextFormField(
             decoration: InputDecoration(
                  hintText: 'Search products',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.grey[200],
                  filled: true,
               ),
            onSaved: (String? value) {
            }
          ),
          actions: [
            Ink(
              padding: const EdgeInsets.fromLTRB(0.0,0.0,10.0,0.0),
              child: IconButton(
                icon: const Icon(Icons.notifications_outlined),
                color: Colors.grey,
                iconSize: 40.0,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Notify()));
            },
          ),
        ),
        ],
      ),
    );
  }
  
  @override
Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}