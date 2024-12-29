import 'package:flutter/material.dart';
import 'new_job_description_form.dart'; // Import the New Job Description Form widget

class JobListingsScreen extends StatefulWidget {
  const JobListingsScreen({super.key});

  @override
  State<JobListingsScreen> createState() => _JobListingsScreenState();
}

class _JobListingsScreenState extends State<JobListingsScreen> {
  String searchQuery = '';

  // Sample job data
  List<Map<String, dynamic>> jobs = [
    {
      'title': 'HR Manager',
      'status': 'Pending',
      'datePosted': 'September 30, 2024',
    },
    {
      'title': 'Assistant Professor',
      'status': 'Draft',
      'datePosted': 'December 21, 2020',
    },
    {
      'title': 'Academic Advisory',
      'status': 'Published',
      'datePosted': 'January 04, 2022',
    },
    {
      'title': 'Professor',
      'status': 'Closed',
      'datePosted': 'November 10, 2024',
    },
  ];

  List<Map<String, dynamic>> get filteredJobs {
    if (searchQuery.isEmpty) return jobs;
    return jobs.where((job) {
      return job['title'].toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to AdminHomeScreen
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1600),
            margin: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.all(36),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey[200]!),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Job Listings',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            width: 500,
                            height: 45,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[300]!),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    onChanged: (value) {
                                      setState(() {
                                        searchQuery = value;
                                      });
                                    },
                                    style: const TextStyle(fontSize: 16),
                                    decoration: InputDecoration(
                                      hintText: 'Search jobs...',
                                      hintStyle: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 16,
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 0,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 16),
                                  child: Icon(Icons.search,
                                      color: Colors.grey[400], size: 24),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 20),
                          SizedBox(
                            height: 45,
                            width: 160,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                // Show the New Job Description form as a dialog
                                showDialog(
                                  context: context,
                                  builder: (context) =>
                                      const NewJobDescriptionForm(),
                                );
                              },
                              icon: const Icon(Icons.add, size: 20),
                              label: const Text(
                                'Add New Job',
                                style: TextStyle(fontSize: 14),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF358873),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 0,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Data Table
                Container(
                  margin: const EdgeInsets.all(36),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[200]!),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        dividerColor: Colors.grey[200],
                      ),
                      child: DataTable(
                        headingRowColor: WidgetStateProperty.all(
                          const Color(0xFF358873),
                        ),
                        dataRowHeight: 65,
                        horizontalMargin: 50,
                        columnSpacing: 36,
                        columns: [
                          DataColumn(
                            label: Container(
                              width: 480,
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                'Vacant Positions',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Container(
                              width: 350,
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                'Status',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Container(
                              width: 350,
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                'Date Posted',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Container(
                              width: 160,
                              alignment: Alignment.center,
                              child: const Text(
                                'Actions',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                        rows: filteredJobs.map((job) {
                          return DataRow(
                            cells: [
                              DataCell(Container(
                                width: 300,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  job['title'],
                                  style: const TextStyle(fontSize: 15),
                                ),
                              )),
                              DataCell(Container(
                                width: 140,
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getStatusColor(job['status']),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    job['status'],
                                    style: TextStyle(
                                      color: _getStatusTextColor(job['status']),
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              )),
                              DataCell(Container(
                                width: 200,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  job['datePosted'],
                                  style: const TextStyle(fontSize: 15),
                                ),
                              )),
                              DataCell(
                                Container(
                                  width: 160,
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.edit,
                                            color: Colors.blue),
                                        onPressed: () {
                                          // Edit functionality
                                          print('Edit ${job['title']} clicked');
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete,
                                            color: Colors.red),
                                        onPressed: () {
                                          // Delete functionality
                                          print(
                                              'Delete ${job['title']} clicked');
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return const Color(0xFFFFF3E0); // Light Orange
      case 'Draft':
        return const Color(0xFFE3F2FD); // Light Blue
      case 'Published':
        return const Color(0xFFE8F5E9); // Light Green
      case 'Closed':
        return const Color(0xFFE3F2FD); // Light Blue
      default:
        return Colors.grey[300]!;
    }
  }

  Color _getStatusTextColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.orange[800]!;
      case 'Draft':
        return Colors.blue[700]!;
      case 'Published':
        return Colors.green[700]!;
      case 'Closed':
        return Colors.blue[700]!;
      default:
        return Colors.grey[600]!;
    }
  }
}
