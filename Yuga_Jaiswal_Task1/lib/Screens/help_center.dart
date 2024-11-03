import 'package:flutter/material.dart';
class HelpCenter extends StatelessWidget {
  const HelpCenter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('24x7 Customer Support'),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hi, how we can help you?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),

                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: const [
                  HelpCenterItem(
                    icon: Icons.grid_view_rounded,
                    title: 'General',
                    subtitle: 'Basic question about Orders',
                    iconColor: Colors.blue,
                  ),
                  HelpCenterItem(
                    icon: Icons.attach_money,
                    title: 'Payment',
                    subtitle: 'Payment related issue',
                    iconColor: Colors.orange,
                  ),
                  HelpCenterItem(
                    icon: Icons.shopping_cart,
                    title: 'Orders',
                    subtitle: 'Orders related issue',
                    iconColor: Colors.red,
                  ),
                  HelpCenterItem(
                    icon: Icons.support_agent_outlined,
                    title: 'Agents',
                    subtitle: 'Contact us at Help Center',
                    iconColor: Colors.blueAccent,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HelpCenterItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color iconColor;

  const HelpCenterItem({super.key, 
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
              padding: const EdgeInsets.symmetric(horizontal:5 ,vertical: 5),
              child: TextButton(
                onPressed: (){
                },
                style: TextButton.styleFrom(
                       padding: const EdgeInsets.symmetric(vertical: 0),
                       iconColor: iconColor,
                        backgroundColor: Colors.grey[200],
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        ),
                child: ListTile(
                    leading: CircleAvatar(
                        backgroundColor: iconColor.withOpacity(0.2),
                        child: Icon(icon, color: iconColor, size: 30),
                      ),
                    title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(subtitle),
                ),
                
                  ),
            );
  }
}