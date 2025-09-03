import 'package:appointment_app/screens/patient_details_screen.dart';
import 'package:flutter/material.dart';

class PatientProfileScreen extends StatelessWidget {
  final Map<String, dynamic> patientData;

  const PatientProfileScreen({super.key, required this.patientData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: const Text(
          'Patient Profile',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1EB6B9),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Patient Header Section
            Container(
              padding: const EdgeInsets.all(16.0),
              color: Colors.white,
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      patientData['image'] as String,
                    ),
                    radius: 40,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              patientData['name'] as String,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${patientData['age']} yrs',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              Icons.phone,
                              size: 16,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              patientData['phone'] as String,
                              style: const TextStyle(color: Colors.grey),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              '|',
                              style: TextStyle(color: Colors.grey),
                            ),
                            const SizedBox(width: 8),
                            InkWell(
                              onTap: () {
                                // Handle view details action
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => PatientDetailsScreen(
                                          patientData: patientData,
                                        ),
                                  ),
                                );
                              },
                              child: const Text(
                                'View Details',
                                style: TextStyle(
                                  color: Color(0xFF1EB6B9),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Appointments Section
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Appointments',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            // Example Appointment List (using static data)
            const AppointmentItem(
              time: '04:00 PM',
              date: 'Tue, 12 Feb 2024',
              status: '', // Upcoming
            ),
            const AppointmentItem(
              time: '10:00 AM',
              date: 'Sat, 9 Feb 2024',
              status: 'Completed',
            ),
            const AppointmentItem(
              time: '10:00 AM',
              date: 'Fri, 8 Feb 2024',
              status: 'Missed',
            ),
          ],
        ),
      ),
    );
  }
}

// A reusable widget for an appointment item
class AppointmentItem extends StatelessWidget {
  final String time;
  final String date;
  final String status;

  const AppointmentItem({
    super.key,
    required this.time,
    required this.date,
    required this.status,
  });

  Color get statusColor {
    switch (status) {
      case 'Completed':
        return Colors.green;
      case 'Missed':
        return Colors.red;
      default:
        return const Color(0xFF1EB6B9);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black12, width: 1.0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                time,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(date, style: const TextStyle(color: Colors.grey)),
            ],
          ),
          Row(
            children: [
              if (status.isNotEmpty)
                Text(
                  '($status)',
                  style: TextStyle(
                    color: statusColor,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              const SizedBox(width: 8),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: statusColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.more_vert, color: Colors.grey),
            ],
          ),
        ],
      ),
    );
  }
}
