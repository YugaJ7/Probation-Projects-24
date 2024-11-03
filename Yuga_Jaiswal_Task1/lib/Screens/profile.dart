//import 'package:ecommerce_app/Components/navbar.dart';
import 'package:ecommerce_app/Screens/Settings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ecommerce_app/Screens/Notification.dart';
import 'package:ecommerce_app/Screens/help_center.dart';
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
              "Profile",
               style: GoogleFonts.poppins(fontSize: 40.0, fontWeight: FontWeight.bold)
              ),
                centerTitle: true,
                backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
       // bottomNavigationBar: Navbar(),
        body: ListView(
          children: [
            const SizedBox(
              height: 200,
              width: 200,
              child: CircleAvatar(
                backgroundImage: AssetImage('asssets/images/self.jpg'),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: TextButton(
                onPressed: (){}, 
                style: TextButton.styleFrom(
                       padding: const EdgeInsets.symmetric(vertical: 15),
                       iconColor: Colors.orangeAccent,
                        backgroundColor: Colors.grey[200],
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        ),
                child:ProfileItem(
                  icon: Icons.person_outline_rounded,
                  title: "My Account",
                ),
                
                  ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: TextButton(
                onPressed: (){
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Notify()));
                }, 
                style: TextButton.styleFrom(
                       padding: const EdgeInsets.symmetric(vertical: 15),
                       iconColor: Colors.orangeAccent,
                        backgroundColor: Colors.grey[200],
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        ),
                child:ProfileItem(
                  icon: Icons.notifications_none_outlined,
                  title: "Notification",
                ),
                
                  ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: TextButton(
                onPressed: (){
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Settings()));
                },
                style: TextButton.styleFrom(
                       padding: const EdgeInsets.symmetric(vertical: 15),
                       iconColor: Colors.orangeAccent,
                        backgroundColor: Colors.grey[200],
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        ),
                child: ProfileItem(
                  icon: Icons.settings_outlined,
                  title: "Settings",
                ),
                
                  ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: TextButton(
                onPressed: (){
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HelpCenter()));
                },
                style: TextButton.styleFrom(
                       padding: const EdgeInsets.symmetric(vertical: 15),
                       iconColor: Colors.orangeAccent,
                        backgroundColor: Colors.grey[200],
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        ),
                child: ProfileItem(
                  icon: Icons.help_outline_rounded,
                  title: "Help Center",
                ),
                
                  ),
            )
            
          ],
        ),
    );
  }
}

class ProfileItem extends StatelessWidget {
  final IconData icon;
  final String title;

  const ProfileItem({super.key, 
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                    children: [
                      Row(
                        children: [
                          const SizedBox(width: 15),
                          Icon(icon,size: 30),
                          const SizedBox(width: 75), 
                          Text(title,style: const TextStyle(fontSize: 18,color: Colors.black),),
                        ],
                      ),
                      const Row(
                        children: [
                          Icon(Icons.arrow_forward_ios_rounded,size: 30,color: Colors.grey,),
                          SizedBox(width: 15),
                        ]
                      )
                    ],
                  );
  }
}