import 'package:appointment_app/screens/patient_profile_card.dart';
import 'package:flutter/material.dart';

class PatientListScreen extends StatefulWidget {
  const PatientListScreen({super.key});

  @override
  State<PatientListScreen> createState() => _PatientListScreenState();
}

class _PatientListScreenState extends State<PatientListScreen> {
  String? _selectedGender;
  String? _selectedAgeRange;

  void _showFilterBottomSheet(BuildContext context) async {
    // Wait for the result from the bottom sheet
    final Map<String, String?>? filters =
        await showModalBottomSheet<Map<String, String?>>(
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return FilterBottomSheet(
              initialGender: _selectedGender,
              initialAgeRange: _selectedAgeRange,
            );
          },
        );

    // Update the state with the new filter values
    if (filters != null) {
      setState(() {
        _selectedGender = filters['gender'];
        _selectedAgeRange = filters['ageRange'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // leading: IconButton(
        //   onPressed: () => Navigator.pop(context),
        //   icon: const Icon(Icons.arrow_back, color: Colors.white),
        // ),
        title: const Text(
          'Patient List',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1EB6B9),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.white),
            onPressed: () => _showFilterBottomSheet(context),
          ),
        ],
      ),
      body: PatientListView(
        selectedGender: _selectedGender,
        selectedAgeRange: _selectedAgeRange,
      ),
    );
  }
}

class FilterBottomSheet extends StatefulWidget {
  final String? initialGender;
  final String? initialAgeRange;

  const FilterBottomSheet({
    super.key,
    this.initialGender,
    this.initialAgeRange,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  String? _selectedGender;
  String? _selectedAgeRange;

  final List<String> genders = ['Male', 'Female', 'Others'];
  final List<String> ageRanges = [
    '0-10',
    '10-20',
    '20-30',
    '30-40',
    '40-50',
    '50-60',
    '60-70',
    'Above 70',
  ];

  @override
  void initState() {
    super.initState();
    // Initialize state with the values passed from the parent widget
    _selectedGender = widget.initialGender;
    _selectedAgeRange = widget.initialAgeRange;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ... (existing UI code for title, close icon)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Filter',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Gender',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8.0,
            children:
                genders.map((gender) {
                  return FilterChip(
                    label: Text(gender),
                    selected: _selectedGender == gender,
                    selectedColor: const Color(0xFF1EB6B9),
                    onSelected: (bool selected) {
                      setState(() {
                        _selectedGender = selected ? gender : null;
                      });
                    },
                  );
                }).toList(),
          ),
          const SizedBox(height: 16),
          const Text(
            'Age Range',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children:
                ageRanges.map((age) {
                  return ChoiceChip(
                    label: Text(age),
                    selected: _selectedAgeRange == age,
                    selectedColor: const Color(0xFF1EB6B9),
                    onSelected: (bool selected) {
                      setState(() {
                        _selectedAgeRange = selected ? age : null;
                      });
                    },
                  );
                }).toList(),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    // Reset the filters and pop the result
                    Navigator.pop(context, {'gender': null, 'ageRange': null});
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF1EB6B9),
                    side: const BorderSide(color: Color(0xFF1EB6B9)),
                  ),
                  child: const Text('Reset'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Pop with the current filter selections
                    Navigator.pop(context, {
                      'gender': _selectedGender,
                      'ageRange': _selectedAgeRange,
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1EB6B9),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Apply'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PatientListView extends StatelessWidget {
  final String? selectedGender;
  final String? selectedAgeRange;

  const PatientListView({
    super.key,
    this.selectedGender,
    this.selectedAgeRange,
  });

  // Dummy data for the patient list
  final List<Map<String, String>> patients = const [
    {
      'name': 'Anupama Gurung',
      'age': '32 years',
      'gender': 'Female',
      'image': 'https://randomuser.me/api/portraits/women/1.jpg',
      'phone': '8854190739',
      'address': 'Kathmandu, Nepal',
      'medicalHistory': 'No',
    },
    {
      'name': 'Ankur Sharma',
      'age': '24 years',
      'gender': 'Male',
      'image': 'https://randomuser.me/api/portraits/men/3.jpg',
      'phone': '8452190739',
      'address': 'Kathmandu, Nepal',
      'medicalHistory': 'No',
    },
    {
      'name': 'Neelam Singh',
      'age': '31 years',
      'gender': 'Female',
      'image': 'https://randomuser.me/api/portraits/women/4.jpg',
      'phone': '5124590739',
      'address': 'Kathmandu, Nepal',
      'medicalHistory': 'Yes',
    },
    {
      'name': 'Mridul Varshney',
      'age': '30 years',
      'gender': 'Male',
      'image': 'https://randomuser.me/api/portraits/men/6.jpg',
      'phone': '7500123039',
      'address': 'Kathmandu, Nepal',
      'medicalHistory': 'No',
    },
    {
      'name': 'Aarav Rana',
      'age': '24 years',
      'gender': 'Male',
      'image': 'https://randomuser.me/api/portraits/men/15.jpg',
      'phone': '8545190739',
      'address': '2/4 ST. Tilak Road, Dehradun',
      'medicalHistory': 'No',
    },
    // Add more patients with 'gender'
  ];

  @override
  Widget build(BuildContext context) {
    // Filter the list based on gender and age range
    final filteredPatients =
        patients.where((patient) {
          final int patientAge = int.parse(patient['age']!.split(' ')[0]);
          final String? patientGender = patient['gender'];

          bool genderMatches =
              selectedGender == null || patientGender == selectedGender;
          bool ageMatches =
              selectedAgeRange == null ||
              _isAgeInRange(patientAge, selectedAgeRange!);

          return genderMatches && ageMatches;
        }).toList();

    return ListView.builder(
      itemCount: filteredPatients.length,
      itemBuilder: (context, index) {
        final patient = filteredPatients[index];
        return PatientCard(
          name: patient['name']!,
          age: patient['age']!,
          imageUrl: patient['image']!,
          patientData: patient,
        );
      },
    );
  }

  // Helper method to check if age is within the selected range
  bool _isAgeInRange(int age, String ageRange) {
    if (ageRange == 'Above 70') {
      return age > 70;
    }
    final parts = ageRange.split('-');
    final int minAge = int.parse(parts[0]);
    final int maxAge = int.parse(parts[1]);
    return age >= minAge && age <= maxAge;
  }
}

class PatientCard extends StatelessWidget {
  final String name;
  final String age;
  final String imageUrl;
  final Map<String, dynamic> patientData; // Pass the entire data map

  const PatientCard({
    required this.name,
    required this.age,
    required this.imageUrl,
    required this.patientData,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(backgroundImage: NetworkImage(imageUrl), radius: 30),
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
                  Text(
                    age,
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
            ),
            // Contact button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            PatientProfileScreen(patientData: patientData),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1EB6B9),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                'Contact',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
