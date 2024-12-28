import 'package:flutter/material.dart';

class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({super.key});

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  String searchQuery = '';
  List<Map<String, dynamic>> employees = [
    {
      'id': '1',
      'name': 'Danilo Santos',
      'department': 'SAM',
      'isActive': true,
      'email': 'admin@admin.com',
      'dateHired': '09/02/22',
    },
    {
      'id': '2',
      'name': 'Xander Ford',
      'department': 'IT',
      'isActive': false,
      'email': 'user@user.com',
      'dateHired': '09/02/22',
    },
    {
      'id': '3',
      'name': 'Jan Hulio Adios',
      'department': 'SAM',
      'isActive': true,
      'email': 'admin@admin.com',
      'dateHired': '09/02/22',
    },
    {
      'id': '4',
      'name': 'Peter Bollies',
      'department': 'IT',
      'isActive': false,
      'email': 'user@user.com',
      'dateHired': '09/02/22',
    },
    {
      'id': '5',
      'name': 'Geaser Jan Gadingan',
      'department': 'SAM',
      'isActive': true,
      'email': 'admin@admin.com',
      'dateHired': '09/02/22',
    },
    {
      'id': '6',
      'name': 'Yasher-Arafat Abam',
      'department': 'IT',
      'isActive': true,
      'email': 'user@user.com',
      'dateHired': '09/02/22',
    },
  ];

  List<Map<String, dynamic>> get filteredEmployees {
    if (searchQuery.isEmpty) return employees;
    return employees.where((employee) {
      return employee['name']
              .toLowerCase()
              .contains(searchQuery.toLowerCase()) ||
          employee['department']
              .toLowerCase()
              .contains(searchQuery.toLowerCase()) ||
          employee['email'].toLowerCase().contains(searchQuery.toLowerCase());
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
                        'Employees',
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
                                      hintText: 'Search employees...',
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
                              onPressed: () {},
                              icon: const Icon(Icons.add, size: 22),
                              label: const Text(
                                'Add Employee',
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
                              width: 100,
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
                              width: 220,
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                'NAME',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Container(
                              width: 180,
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                'DEPARTMENT',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Container(
                              width: 140,
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                'STATUS',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Container(
                              width: 280,
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                'EMAIL',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Container(
                              width: 140,
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                'DATE HIRED',
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
                                'ACTIONS',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                        rows: filteredEmployees.map((employee) {
                          return DataRow(
                            cells: [
                              DataCell(Container(
                                width: 100,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  employee['id'],
                                  style: const TextStyle(fontSize: 15),
                                ),
                              )),
                              DataCell(Container(
                                width: 220,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  employee['name'],
                                  style: const TextStyle(fontSize: 15),
                                ),
                              )),
                              DataCell(Container(
                                width: 180,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  employee['department'],
                                  style: const TextStyle(fontSize: 15),
                                ),
                              )),
                              DataCell(
                                Container(
                                  width: 140,
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: employee['isActive']
                                          ? const Color(0xFFE8F5E9)
                                          : const Color(0xFFFFF3E0),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      employee['isActive']
                                          ? 'Active'
                                          : 'On Leave',
                                      style: TextStyle(
                                        color: employee['isActive']
                                            ? const Color(0xFF358873)
                                            : Colors.orange[700],
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              DataCell(Container(
                                width: 280,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  employee['email'],
                                  style: const TextStyle(fontSize: 15),
                                ),
                              )),
                              DataCell(Container(
                                width: 140,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  employee['dateHired'],
                                  style: const TextStyle(fontSize: 15),
                                ),
                              )),
                              DataCell(
                                Container(
                                  width: 160,
                                  alignment: Alignment.center,
                                  child: Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      color: Colors.red[50],
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      icon: const Icon(Icons.close,
                                          size: 20, color: Colors.red),
                                      onPressed: () {
                                        setState(() {
                                          employees.remove(employee);
                                        });
                                      },
                                    ),
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
}
