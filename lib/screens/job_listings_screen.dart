import 'package:flutter/material.dart';
import 'new_job_description_form.dart'; // Import the New Job Description Form widget

class JobListingsScreen extends StatefulWidget {
  const JobListingsScreen({super.key});

  @override
  State<JobListingsScreen> createState() => _JobListingsScreenState();
}

class _JobListingsScreenState extends State<JobListingsScreen> {
  String searchQuery = '';
  String selectedFilter = 'All'; // For filtering by status
  bool isAscending = true; // For sorting
  int currentPage = 1; // Pagination
  final int itemsPerPage = 5;

  // Sample job data
  List<Map<String, dynamic>> allJobs = [
    {'title': 'HR Manager', 'status': 'Pending', 'datePosted': '2024-09-30'},
    {
      'title': 'Assistant Professor',
      'status': 'Draft',
      'datePosted': '2020-12-21'
    },
    {
      'title': 'Academic Advisory',
      'status': 'Published',
      'datePosted': '2022-01-04'
    },
    {'title': 'Professor', 'status': 'Closed', 'datePosted': '2024-11-10'},
    {'title': 'Researcher', 'status': 'Published', 'datePosted': '2023-03-15'},
    {
      'title': 'Software Engineer',
      'status': 'Draft',
      'datePosted': '2023-06-12'
    },
    {'title': 'Data Analyst', 'status': 'Pending', 'datePosted': '2023-08-01'},
  ];

  List<Map<String, dynamic>> get filteredJobs {
    List<Map<String, dynamic>> jobs = allJobs;

    // Filter by status
    if (selectedFilter != 'All') {
      jobs = jobs.where((job) => job['status'] == selectedFilter).toList();
    }

    // Search query filter
    if (searchQuery.isNotEmpty) {
      jobs = jobs.where((job) {
        return job['title'].toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }

    // Sort by title
    jobs.sort((a, b) => isAscending
        ? a['title'].compareTo(b['title'])
        : b['title'].compareTo(a['title']));

    return jobs;
  }

  List<Map<String, dynamic>> get paginatedJobs {
    int startIndex = (currentPage - 1) * itemsPerPage;
    int endIndex = startIndex + itemsPerPage;
    return filteredJobs.sublist(
      startIndex,
      endIndex > filteredJobs.length ? filteredJobs.length : endIndex,
    );
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
                          DropdownButton<String>(
                            value: selectedFilter,
                            onChanged: (value) {
                              setState(() {
                                selectedFilter = value!;
                                currentPage = 1; // Reset to the first page
                              });
                            },
                            items: [
                              'All',
                              'Pending',
                              'Draft',
                              'Published',
                              'Closed'
                            ].map<DropdownMenuItem<String>>((String value) {
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
                                      hintText: 'Search jobs...',
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
                          ElevatedButton.icon(
                            onPressed: () {
                              // Show the New Job Description form as a dialog
                              showDialog(
                                context: context,
                                builder: (context) =>
                                    const NewJobDescriptionForm(),
                              );
                            },
                            icon: const Icon(Icons.add, color: Colors.white),
                            label: const Text(
                              'Add New Job',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF358873),
                              minimumSize: const Size(160, 45),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
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
                                width:
                                    350, // Adjusted width for Vacant Positions
                                child: Text(
                                  'Vacant Positions',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                width: 350, // Adjusted width for Status
                                child: Text(
                                  'Status',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                width: 350, // Adjusted width for Date Posted
                                child: Text(
                                  'Date Posted',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                width: 350, // Adjusted width for Actions
                                child: Text(
                                  'Actions',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                          rows: paginatedJobs.map((job) {
                            return DataRow(
                              cells: [
                                DataCell(SizedBox(
                                  width: 350,
                                  child: Text(job['title']),
                                )),
                                DataCell(SizedBox(
                                  width: 350,
                                  child: Text(job['status']),
                                )),
                                DataCell(SizedBox(
                                  width: 350,
                                  child: Text(job['datePosted']),
                                )),
                                DataCell(SizedBox(
                                  width: 350,
                                  child: Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.edit),
                                        onPressed: () {},
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                )),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                      // Pagination Controls
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
                              'Page $currentPage of ${(filteredJobs.length / itemsPerPage).ceil()}'),
                          IconButton(
                            onPressed: currentPage <
                                    (filteredJobs.length / itemsPerPage).ceil()
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
