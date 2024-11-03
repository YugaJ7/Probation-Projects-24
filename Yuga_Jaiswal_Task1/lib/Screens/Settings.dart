import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool pushNotification = false;
  bool location = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
        const Text('PROFILE', style: TextStyle(color: Colors.grey, fontSize: 12)),
          SwitchListTile(
            title: const Text('Push Notification'),
            value: pushNotification,
            activeColor: Colors.orange,
            onChanged: (bool value) {
              setState(() {
                pushNotification = value;
              });
            },
          ),
          SwitchListTile(
            title: const Text('Location'),
            value: location,
            activeColor: Colors.orange,
            onChanged: (bool value) {
              setState(() {
                location = value;
              });
            },
          ),
          ListTile(
            title: const Text('Language'),
            subtitle: const Text('English'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
          const SizedBox(height: 20),

          const Text('OTHER', style: TextStyle(color: Colors.grey, fontSize: 12)),
          ListTile(
            title: const Text('Questions & Answers'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Privacy Policy'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Terms and Conditions'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}