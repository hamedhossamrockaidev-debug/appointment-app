import 'package:appointment_app/screens/appointments_screen.dart';
import 'package:flutter/material.dart';

class PatientDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> patientData;

  const PatientDetailsScreen({super.key, required this.patientData});

  @override
  State<PatientDetailsScreen> createState() => _PatientDetailsScreenState();
}

class _PatientDetailsScreenState extends State<PatientDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: const Text(
          'Patient Details',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1EB6B9),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Patient Header Section
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      widget.patientData['image'] as String,
                    ),
                    radius: 30,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.patientData['name'] as String,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${widget.patientData['age']} yrs',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  // This part is static for this screen based on your image
                  const Text(
                    'Wed, 12 May 24 | 10:00 PM',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildActionButton(
                    icon: Icons.check_circle_outline,
                    label: 'Mark as Completed',
                    color: Colors.green,
                    onTap: () {},
                  ),
                  _buildActionButton(
                    icon: Icons.cancel_outlined,
                    label: 'Cancel\nAppointment',
                    color: Colors.red,
                    onTap: () {
                      // Handle cancel action
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Cancel Appointment'),
                            content: const Text(
                              'Are you sure you want to cancel this appointment?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('No'),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Handle cancel action
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Appointment canceled!'),
                                    ),
                                  );
                                },
                                child: const Text('Yes'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  _buildActionButton(
                    icon: Icons.schedule,
                    label: 'Reschedule\nAppointment',
                    color: Colors.orange,
                    onTap: () {
                      // Handle reschedule action
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => SelectDateTimeScreen(
                                patient: Patient(
                                  name: widget.patientData['name'],
                                  imageUrl: widget.patientData['image'],
                                ),
                              ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Patient Details Section
              const Text(
                'Patient Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _buildDetailRow('Full Name:', widget.patientData['name']),
              _buildDetailRow('Age:', '${widget.patientData['age']} years'),
              _buildDetailRow('Gender:', widget.patientData['gender']),
              _buildDetailRow('Phone No:', widget.patientData['phone']),
              _buildDetailRow('Address:', widget.patientData['address']),
              _buildDetailRow(
                'Medical History:',
                widget.patientData['medicalHistory'] ?? 'No',
              ),
              const SizedBox(height: 24),

              // Prescriptions Section
              const Text(
                'Prescriptions',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  _buildPrescriptionCard(
                    'https://img.freepik.com/free-vector/prescription-template-design_23-2149731350.jpg',
                  ), // Use NetworkImage if URL
                  const SizedBox(width: 16),
                  _buildPrescriptionCard(
                    'https://thumbs.dreamstime.com/b/professional-rx-prescription-pad-mockup-business-promotion-professional-rx-prescription-pad-mockup-business-promotion-293431928.jpg',
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle save button tap
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Patient details saved!')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1EB6B9),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Save', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method for the action buttons
  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.1),
            child: Icon(icon, color: color, size: 30),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(color: color, fontSize: 12),
          ),
        ],
      ),
    );
  }

  // Helper method for patient details rows
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  // Helper method for prescription cards
  Widget _buildPrescriptionCard(String imageUrl) {
    return Expanded(
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            image: NetworkImage(imageUrl), // Or NetworkImage if from the web
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
