import 'package:flutter/material.dart';

class InterviewScreen extends StatefulWidget {
  const InterviewScreen({super.key});

  @override
  State<InterviewScreen> createState() => _InterviewScreenState();
}

class _InterviewScreenState extends State<InterviewScreen> {
  String searchQuery = '';
  List<Map<String, dynamic>> interviews = [
    {
      'id': '1',
      'candidateName': 'Alice Johnson',
      'position': 'Software Engineer',
      'date': '09/15/2023',
      'status': 'Scheduled',
    },
    {
      'id': '2',
      'candidateName': 'Bob Smith',
      'position': 'Product Manager',
      'date': '09/16/2023',
      'status': 'Completed',
    },
    {
      'id': '3',
      'candidateName': 'Charlie Brown',
      'position': 'Data Analyst',
      'date': '09/17/2023',
      'status': 'Scheduled',
    },
    {
      'id': '4',
      'candidateName': 'Diana Prince',
      'position': 'UX Designer',
      'date': '09/18/2023',
      'status': 'Completed',
    },
    {
      'id': '5',
      'candidateName': 'Ethan Hunt',
      'position': 'Project Coordinator',
      'date': '09/19/2023',
      'status': 'Scheduled',
    },
    {
      'id': '6',
      'candidateName': 'Fiona Gallagher',
      'position': 'Marketing Specialist',
      'date': '09/20/2023',
      'status': 'Completed',
    },
  ];

  List<Map<String, dynamic>> get filteredInterviews {
    if (searchQuery.isEmpty) return interviews;
    return interviews.where((interview) {
      return interview['candidateName']
              .toLowerCase()
              .contains(searchQuery.toLowerCase()) ||
          interview['position']
              .toLowerCase()
              .contains(searchQuery.toLowerCase());
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
                        'Interviews',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
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
                                  hintText: 'Search interviews...',
                                  hintStyle: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: 16,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
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
                    ],
                  ),
                ),
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
                        headingRowColor:
                            WidgetStateProperty.all(const Color(0xFF358873)),
                        dataRowHeight: 65,
                        horizontalMargin: 50,
                        columnSpacing: 36,
                        columns: [
                          DataColumn(
                            label: Container(
                              width: 300,
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                'ID',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Container(
                              width: 300,
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                'Candidate Name',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Container(
                              width: 300,
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                'Position',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Container(
                              width: 300,
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                'Date',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Container(
                              width: 300,
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
                        ],
                        rows: filteredInterviews.map((interview) {
                          return DataRow(
                            cells: [
                              DataCell(Container(
                                width: 100,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  interview['id'],
                                  style: const TextStyle(fontSize: 15),
                                ),
                              )),
                              DataCell(Container(
                                width: 220,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  interview['candidateName'],
                                  style: const TextStyle(fontSize: 15),
                                ),
                              )),
                              DataCell(Container(
                                width: 180,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  interview['position'],
                                  style: const TextStyle(fontSize: 15),
                                ),
                              )),
                              DataCell(Container(
                                width: 140,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  interview['date'],
                                  style: const TextStyle(fontSize: 15),
                                ),
                              )),
                              DataCell(Container(
                                width: 140,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  interview['status'],
                                  style: const TextStyle(fontSize: 15),
                                ),
                              )),
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
  // EdgeInsets.only(top: 30, bottom: 160), // Move up
}
