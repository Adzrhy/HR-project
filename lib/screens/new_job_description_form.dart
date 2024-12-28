import 'package:flutter/material.dart';

class NewJobDescriptionForm extends StatefulWidget {
  const NewJobDescriptionForm({Key? key}) : super(key: key);

  @override
  _NewJobDescriptionFormState createState() => _NewJobDescriptionFormState();
}

class _NewJobDescriptionFormState extends State<NewJobDescriptionForm> {
  final List<String> departments = ['Engineering', 'HR'];
  final List<String> employmentStatuses = [
    'Pending',
    'Draft',
    'Published',
    'Closed'
  ];
  final List<String> campuses = ['Main Campus', 'City Campus'];

  String? selectedDepartment;
  String? selectedEmploymentStatus;
  String? selectedCampus;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        width: 600,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'New Job Description',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Job Position
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Job Position',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Description
              const TextField(
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Department and Employment Status
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: selectedDepartment,
                      hint: const Text('Department'),
                      decoration: const InputDecoration(
                        labelText: 'Department',
                        border: OutlineInputBorder(),
                      ),
                      items: departments
                          .map((dept) => DropdownMenuItem<String>(
                                value: dept,
                                child: Text(dept),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedDepartment = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: selectedEmploymentStatus,
                      hint: const Text('Employment Status'),
                      decoration: const InputDecoration(
                        labelText: 'Employment Status',
                        border: OutlineInputBorder(),
                      ),
                      items: employmentStatuses
                          .map((status) => DropdownMenuItem<String>(
                                value: status,
                                child: Text(status),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedEmploymentStatus = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Section and Campus
              Row(
                children: [
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Section',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: selectedCampus,
                      hint: const Text('Campus'),
                      decoration: const InputDecoration(
                        labelText: 'Campus',
                        border: OutlineInputBorder(),
                      ),
                      items: campuses
                          .map((campus) => DropdownMenuItem<String>(
                                value: campus,
                                child: Text(campus),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedCampus = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Requirements
              const TextField(
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Requirements',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Published On and Tags
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      readOnly: true,
                      onTap: () async {
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            // Add functionality to update the published on field
                          });
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Published on',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Tags',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Save and Cancel Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                    ),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Add save functionality
                      print('Saved');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
