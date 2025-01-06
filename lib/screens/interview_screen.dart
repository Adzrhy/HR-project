import 'package:flutter/material.dart';

class InterviewScreen extends StatefulWidget {
  const InterviewScreen({super.key});

  @override
  State<InterviewScreen> createState() => _InterviewScreenState();
}

class _InterviewScreenState extends State<InterviewScreen> {
  String searchQuery = '';
  String selectedFilter = 'All';
  int currentPage = 1; // Pagination
  final int itemsPerPage = 5;

  List<Map<String, dynamic>> interviews = [
    {
      'time': '9:00 AM',
      'applicantName': 'Alice Johnson',
      'position': 'Software Engineer',
      'date': '01/15/23'
    },
    {
      'time': '10:30 AM',
      'applicantName': 'Bob Smith',
      'position': 'Product Manager',
      'date': '02/20/23'
    },
    {
      'time': '11:00 AM',
      'applicantName': 'Charlie Brown',
      'position': 'Data Analyst',
      'date': '03/12/23'
    },
    {
      'time': '2:00 PM',
      'applicantName': 'Diana Prince',
      'position': 'UX Designer',
      'date': '04/05/23'
    },
    {
      'time': '3:30 PM',
      'applicantName': 'Ethan Hunt',
      'position': 'Marketing Specialist',
      'date': '05/22/23'
    },
    {
      'time': '9:30 AM',
      'applicantName': 'Fiona Gallagher',
      'position': 'HR Manager',
      'date': '06/15/23'
    },
    {
      'time': '10:00 AM',
      'applicantName': 'George Lucas',
      'position': 'Operations Lead',
      'date': '07/10/23'
    },
    {
      'time': '1:30 PM',
      'applicantName': 'Helen Parr',
      'position': 'Finance Officer',
      'date': '08/25/23'
    },
    {
      'time': '3:00 PM',
      'applicantName': 'Isaac Newton',
      'position': 'Research Scientist',
      'date': '09/18/23'
    },
    {
      'time': '4:30 PM',
      'applicantName': 'Jack Sparrow',
      'position': 'Logistics Coordinator',
      'date': '10/12/23'
    },
  ];

  List<Map<String, dynamic>> get filteredInterviews {
    List<Map<String, dynamic>> filtered = interviews;

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((interview) {
        return interview['applicantName']
                .toLowerCase()
                .contains(searchQuery.toLowerCase()) ||
            interview['position']
                .toLowerCase()
                .contains(searchQuery.toLowerCase());
      }).toList();
    }

    return filtered;
  }

  List<Map<String, dynamic>> get paginatedInterviews {
    int startIndex = (currentPage - 1) * itemsPerPage;
    int endIndex = startIndex + itemsPerPage;
    return filteredInterviews.sublist(
      startIndex,
      endIndex > filteredInterviews.length
          ? filteredInterviews.length
          : endIndex,
    );
  }

  void addNewSchedule() {
    setState(() {
      interviews.add({
        'time': '5:00 PM',
        'applicantName': 'New Applicant',
        'position': 'Intern',
        'date': '11/20/23'
      });
    });
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
                        'Interviews',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        children: [
                          DropdownButton<String>(
                            value: selectedFilter,
                            onChanged: (value) {
                              setState(() {
                                selectedFilter = value!;
                                currentPage = 1; // Reset to the first page
                              });
                            },
                            items: ['All', 'Scheduled', 'Completed']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                          const SizedBox(width: 20),
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
                                        currentPage =
                                            1; // Reset to the first page
                                      });
                                    },
                                    style: const TextStyle(fontSize: 16),
                                    decoration: InputDecoration(
                                      hintText: 'Search schedules...',
                                      hintStyle: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 16,
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 0,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: Icon(Icons.search,
                                      color: Colors.grey[400], size: 24),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 20),
                          SizedBox(
                            height: 45,
                            width: 200,
                            child: ElevatedButton.icon(
                              onPressed: addNewSchedule,
                              icon: const Icon(Icons.add, size: 20),
                              label: const Text(
                                'Add New Schedule',
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
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          headingRowColor: MaterialStateProperty.all(
                            const Color(0xFF358873),
                          ),
                          columns: const [
                            DataColumn(
                              label: SizedBox(
                                width: 200,
                                child: Text(
                                  'Time',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                width: 350,
                                child: Text(
                                  'Applicant Name',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                width: 350,
                                child: Text(
                                  'Position',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                width: 350,
                                child: Text(
                                  'Date',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                          rows: paginatedInterviews.map((interview) {
                            return DataRow(
                              cells: [
                                DataCell(SizedBox(
                                  width: 200,
                                  child: Text(interview['time']),
                                )),
                                DataCell(SizedBox(
                                  width: 350,
                                  child: Text(interview['applicantName']),
                                )),
                                DataCell(SizedBox(
                                  width: 350,
                                  child: Text(interview['position']),
                                )),
                                DataCell(SizedBox(
                                  width: 350,
                                  child: Text(interview['date']),
                                )),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: currentPage > 1
                                ? () {
                                    setState(() {
                                      currentPage--;
                                    });
                                  }
                                : null,
                            icon: const Icon(Icons.arrow_back),
                          ),
                          Text(
                              'Page $currentPage of ${(filteredInterviews.length / itemsPerPage).ceil()}'),
                          IconButton(
                            onPressed: currentPage <
                                    (filteredInterviews.length / itemsPerPage)
                                        .ceil()
                                ? () {
                                    setState(() {
                                      currentPage++;
                                    });
                                  }
                                : null,
                            icon: const Icon(Icons.arrow_forward),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
