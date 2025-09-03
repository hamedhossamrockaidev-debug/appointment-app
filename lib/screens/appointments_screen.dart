import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AppointmentsScreenState createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  // A boolean to toggle the search bar visibility
  bool _isSearching = false;
  // A controller to manage the text in the search field
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Method to toggle the search state
  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchController.clear(); // Clear search text when search is closed
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF1EB6B9),
          automaticallyImplyLeading: false,
          // leading: IconButton(
          //   onPressed: () => Navigator.pop(context),
          //   icon: const Icon(Icons.arrow_back, color: Colors.white),
          // ),
          title:
              _isSearching
                  ? TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search by name...',
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.white70),
                    ),
                    style: const TextStyle(color: Colors.white),
                    onChanged: (query) {
                      // This will trigger the list to rebuild and filter
                      setState(() {});
                    },
                  )
                  : const Text(
                    'Appointments',
                    style: TextStyle(color: Colors.white),
                  ),
          centerTitle: false,
          actions: [
            IconButton(
              icon: Icon(
                _isSearching ? Icons.close : Icons.search,
                color: Colors.white,
              ),
              onPressed: _toggleSearch,
            ),
          ],
          bottom:
              _isSearching
                  ? null
                  : const TabBar(
                    indicatorColor: Colors.white,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.white70,
                    tabs: [
                      Tab(text: 'Upcoming'),
                      Tab(text: 'Missed'),
                      Tab(text: 'Completed'),
                    ],
                  ),
        ),
        body: TabBarView(
          children: [
            // Pass the search query to each list widget
            UpcomingAppointmentsList(searchQuery: _searchController.text),
            MissedAppointmentsList(searchQuery: _searchController.text),
            CompletedAppointmentsList(searchQuery: _searchController.text),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Handle new appointment creation
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SelectPatientScreen(),
              ),
            );
          },
          backgroundColor: const Color(0xFF1EB6B9),
          shape: const CircleBorder(),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}

class UpcomingAppointmentsList extends StatelessWidget {
  final String searchQuery;

  final List<Map<String, String>> appointments = [
    {
      'name': 'Anupama Gurung',
      'age': '32 years',
      'time': '10.00 AM',
      'image': 'https://randomuser.me/api/portraits/women/1.jpg',
    },
    {
      'name': 'Deepa Gupta',
      'age': '27 years',
      'time': '10.30 AM',
      'image': 'https://randomuser.me/api/portraits/women/2.jpg',
    },
    {
      'name': 'Ankur Sharma',
      'age': '24 years',
      'time': '11.00 AM',
      'image': 'https://randomuser.me/api/portraits/men/3.jpg',
    },
    {
      'name': 'Neelam Singh',
      'age': '31 years',
      'time': '11.30 AM',
      'image': 'https://randomuser.me/api/portraits/women/4.jpg',
    },
    {
      'name': 'Jayshree Singhal',
      'age': '48 years',
      'time': '12.00 PM',
      'image': 'https://randomuser.me/api/portraits/women/5.jpg',
    },
    {
      'name': 'Mridul Varshney',
      'age': '30 years',
      'time': '12.30 PM',
      'image': 'https://randomuser.me/api/portraits/men/6.jpg',
    },
    {
      'name': 'Leena Dutta',
      'age': '33 years',
      'time': '04.00 PM',
      'image': 'https://randomuser.me/api/portraits/women/7.jpg',
    },
  ];

  UpcomingAppointmentsList({super.key, required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    final filteredList =
        appointments
            .where(
              (appointment) => appointment['name']!.toLowerCase().contains(
                searchQuery.toLowerCase(),
              ),
            )
            .toList();

    return Column(
      children: [
        // Today section
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Today',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredList.length,
            itemBuilder: (context, index) {
              final appointment = filteredList[index];
              return AppointmentCard(
                name: appointment['name']!,
                age: appointment['age']!,
                time: appointment['time']!,
                imageUrl: appointment['image']!,
                statusColor: Colors.green,
              );
            },
          ),
        ),
        // "View past appointments" button
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: InkWell(
            onTap: () {
              // Handle navigation to past appointments
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'View past appointments',
                  style: TextStyle(
                    color: Color(0xFF1EB6B9),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Icon(Icons.chevron_right, color: Color(0xFF1EB6B9)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class MissedAppointmentsList extends StatelessWidget {
  final String searchQuery;

  final List<Map<String, String>> missedAppointments = [
    {
      'name': 'Preeti Semwal',
      'age': '27 years',
      'time': '10.00 AM',
      'image': 'https://randomuser.me/api/portraits/women/8.jpg',
    },
    {
      'name': 'Rakendu Das',
      'age': '28 years',
      'time': '09.30 AM',
      'image': 'https://randomuser.me/api/portraits/men/9.jpg',
    },
  ];

  MissedAppointmentsList({super.key, required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    final filteredList =
        missedAppointments
            .where(
              (appointment) => appointment['name']!.toLowerCase().contains(
                searchQuery.toLowerCase(),
              ),
            )
            .toList();
    return Column(
      children: [
        // Today section
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Today',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredList.length,
            itemBuilder: (context, index) {
              final appointment = filteredList[index];
              return AppointmentCard(
                name: appointment['name']!,
                age: appointment['age']!,
                time: appointment['time']!,
                imageUrl: appointment['image']!,
                statusColor: Colors.red, // Pass the red color for missed status
              );
            },
          ),
        ),
        // "View past appointments" button
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: InkWell(
            onTap: () {
              // Handle navigation to past appointments
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'View past appointments',
                  style: TextStyle(
                    color: Color(0xFF1EB6B9),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Icon(Icons.chevron_right, color: Color(0xFF1EB6B9)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CompletedAppointmentsList extends StatelessWidget {
  final String searchQuery;
  final List<Map<String, String>> completedAppointments = [
    {
      'name': 'Poonam Bhatt',
      'age': '24 years',
      'time': '05.00 PM',
      'image': 'https://randomuser.me/api/portraits/women/10.jpg',
    },
    {
      'name': 'Aiswarya Rohilla',
      'age': '32 years',
      'time': '04.00 PM',
      'image': 'https://randomuser.me/api/portraits/women/11.jpg',
    },
    {
      'name': 'Anant Sagar',
      'age': '37 years',
      'time': '12.30 PM',
      'image': 'https://randomuser.me/api/portraits/men/12.jpg',
    },
    {
      'name': 'Deepmala Rey',
      'age': '52 years',
      'time': '12.00 PM',
      'image': 'https://randomuser.me/api/portraits/women/13.jpg',
    },
  ];

  CompletedAppointmentsList({super.key, required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    final filteredList =
        completedAppointments
            .where(
              (appointment) => appointment['name']!.toLowerCase().contains(
                searchQuery.toLowerCase(),
              ),
            )
            .toList();
    return Column(
      children: [
        // "Today" section header
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Today',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
          ),
        ),
        // The list of completed appointments
        Expanded(
          child: ListView.builder(
            itemCount: filteredList.length,
            itemBuilder: (context, index) {
              final appointment = completedAppointments[index];
              return AppointmentCard(
                name: appointment['name']!,
                age: appointment['age']!,
                time: appointment['time']!,
                imageUrl: appointment['image']!,
                statusColor: Colors.green, // Use green for completed
              );
            },
          ),
        ),
        // "View past appointments" button
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: InkWell(
            onTap: () {
              // Handle navigation to past appointments
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'View past appointments',
                  style: TextStyle(
                    color: Color(0xFF1EB6B9),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Icon(Icons.chevron_right, color: Color(0xFF1EB6B9)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final String name;
  final String age;
  final String time;
  final String imageUrl;
  final Color statusColor; // New parameter

  const AppointmentCard({
    super.key,
    required this.name,
    required this.age,
    required this.time,
    required this.imageUrl,
    required this.statusColor, // Make it required
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black12, width: 1.0)),
      ),
      child: Row(
        children: [
          CircleAvatar(backgroundImage: NetworkImage(imageUrl), radius: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      age,
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    const Text(' | '),
                    Text(
                      time,
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    const SizedBox(width: 4),
                    // Use the statusColor here
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: statusColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Icon(Icons.more_vert, color: Colors.grey),
        ],
      ),
    );
  }
}

// A simplified patient data model for this example
class Patient {
  final String name;
  final String imageUrl;

  const Patient({required this.name, required this.imageUrl});
}

class SelectPatientScreen extends StatelessWidget {
  const SelectPatientScreen({super.key});

  final List<Patient> patients = const [
    Patient(
      name: 'Anupama Gurung',
      imageUrl: 'https://randomuser.me/api/portraits/women/1.jpg',
    ),
    Patient(
      name: 'Deepa Gupta',
      imageUrl: 'https://randomuser.me/api/portraits/women/2.jpg',
    ),
    Patient(
      name: 'Ankur Sharma',
      imageUrl: 'https://randomuser.me/api/portraits/men/3.jpg',
    ),
    // ... add more patients here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Select Patient',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1EB6B9),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        itemCount: patients.length,
        itemBuilder: (context, index) {
          final patient = patients[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(patient.imageUrl),
            ),
            title: Text(patient.name),
            onTap: () {
              // Navigate to the next screen and pass the selected patient's data
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SelectDateTimeScreen(patient: patient),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class SelectDateTimeScreen extends StatefulWidget {
  final Patient patient;

  const SelectDateTimeScreen({super.key, required this.patient});

  @override
  State<SelectDateTimeScreen> createState() => _SelectDateTimeScreenState();
}

class _SelectDateTimeScreenState extends State<SelectDateTimeScreen> {
  DateTime _selectedDate = DateTime.now();
  String? _selectedTime;

  // Dummy time slots for a day
  final List<String> timeSlots = [
    '09:00 AM',
    '10:00 AM',
    '11:00 AM',
    '01:00 PM',
    '02:00 PM',
    '03:00 PM',
    '04:00 PM',
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'New Appointment',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1EB6B9),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Patient details section
            Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(widget.patient.imageUrl),
                ),
                title: Text(widget.patient.name),
                subtitle: const Text('New Appointment'),
              ),
            ),
            const SizedBox(height: 24),

            // Date selection
            const Text(
              'Select Date',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ListTile(
              leading: const Icon(
                Icons.calendar_today,
                color: Color(0xFF1EB6B9),
              ),
              title: Text(DateFormat('EEEE, MMMM d, y').format(_selectedDate)),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _selectDate(context),
            ),
            const Divider(),
            const SizedBox(height: 16),

            // Time selection
            const Text(
              'Select Time',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children:
                  timeSlots.map((time) {
                    return ChoiceChip(
                      label: Text(time),
                      selected: _selectedTime == time,
                      selectedColor: const Color(0xFF1EB6B9),
                      onSelected: (bool selected) {
                        setState(() {
                          _selectedTime = selected ? time : null;
                        });
                      },
                    );
                  }).toList(),
            ),
            const SizedBox(height: 32),

            // Confirmation Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed:
                    _selectedTime != null
                        ? () {
                          // Logic to finalize the appointment
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Appointment set for ${widget.patient.name} on ${DateFormat('MMM d').format(_selectedDate)} at $_selectedTime',
                              ),
                            ),
                          );
                          // Navigate back to the main Appointments screen or a confirmation screen
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }
                        : null, // Button is disabled if no time is selected
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1EB6B9),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Set Appointment',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
