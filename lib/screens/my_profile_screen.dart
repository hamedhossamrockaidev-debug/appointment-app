import 'package:appointment_app/main.dart';
import 'package:flutter/material.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  bool _isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // leading: IconButton(
        //   onPressed: () => Navigator.pop(context),
        //   icon: const Icon(Icons.arrow_back, color: Colors.white),
        // ),
        title: const Text('Profile', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF1EB6B9),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header Section
            Container(
              color: const Color(0xFF1EB6B9),
              padding: const EdgeInsets.symmetric(vertical: 32.0),
              width: double.infinity,
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      'https://randomuser.me/api/portraits/women/44.jpg',
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Dr. Neelam Joshi',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // Options List
            _buildProfileOption(
              context,
              'Today\'s Availability',
              isSwitch: true,
            ),
            _buildProfileOption(
              context,
              'Upcoming Availability',
              icon: Icons.chevron_right,
              onTap: () {
                // Navigate to upcoming availability screen
              },
            ),
            _buildProfileOption(
              context,
              'Logout',
              icon: Icons.chevron_right,
              color: Colors.red,
              onTap: () {
                // Handle logout logic
                // For example, navigate to the login screen
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Logged out successfully!')),
                );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // A reusable widget for each profile option
  Widget _buildProfileOption(
    BuildContext context,
    String title, {
    IconData? icon,
    Color? color,
    VoidCallback? onTap,
    bool isSwitch = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: color ?? Colors.black,
              ),
            ),
            if (isSwitch)
              Switch(
                value:
                    _isSwitched, // You can manage this state with a StatefulWidget
                onChanged: (value) {
                  setState(() {
                    _isSwitched = value;
                  });
                },
                activeColor: const Color(0xFF1EB6B9),
              )
            else if (icon != null)
              Icon(icon),
          ],
        ),
      ),
    );
  }
}
