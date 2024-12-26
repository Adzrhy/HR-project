import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'job_listings_screen.dart'; // Import the Job Listings screen

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  bool isSidebarOpen = true;
  bool isNotificationVisible = false;
  bool isDropdownOpen = false;

  final GlobalKey dropdownKey = GlobalKey();

  void _toggleDropdown() {
    setState(() {
      isDropdownOpen = !isDropdownOpen;
    });
  }

  void _onCardTap(String title) {
    switch (title) {
      case 'Forms':
        Navigator.pushNamed(context, '');
        break;
      case 'Lists':
        break;
      default:
        print('No action defined for $title');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Row(
        children: [
          // Sidebar
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: isSidebarOpen ? 250 : 0,
            child: Container(
              color: Colors.white,
              child: isSidebarOpen
                  ? Column(
                      children: [
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () =>
                                setState(() => isSidebarOpen = false),
                          ),
                        ),
                        ListTile(
                          leading: const Icon(Icons.dashboard, size: 20),
                          title: const Text('Home',
                              style: TextStyle(fontSize: 14)),
                          selected: true,
                          selectedColor: Colors.blue,
                          onTap: () {},
                        ),
                        ListTile(
                          leading: const Icon(Icons.work, size: 20),
                          title: const Text('Jobs',
                              style: TextStyle(fontSize: 14)),
                          onTap: () {
                            // Navigate to the Job Listings screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const JobListingsScreen(),
                              ),
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.list, size: 20),
                          title: const Text('Lists',
                              style: TextStyle(fontSize: 14)),
                          onTap: () => _onCardTap('Lists'),
                        ),
                        ListTile(
                          leading: const Icon(Icons.assignment, size: 20),
                          title: const Text('Forms',
                              style: TextStyle(fontSize: 14)),
                          onTap: () => _onCardTap('Forms'),
                        ),
                        const Spacer(),
                        const Divider(height: 5),
                        const Padding(
                          padding: EdgeInsets.only(top: 30, bottom: 120),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundImage: AssetImage(
                                    'assets/image.png'), // Update with your image
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Admin User',
                                style: TextStyle(fontSize: 14),
                              ),
                              Text(
                                'admin@example.com',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : null,
            ),
          ),
          // Main Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Stack(
                children: [
                  Column(
                    children: [
                      // Admin and Notification Bar
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Dashboard',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.notifications),
                                onPressed: () {
                                  setState(() {
                                    isNotificationVisible =
                                        !isNotificationVisible;
                                  });
                                },
                              ),
                              const SizedBox(width: 8),
                              GestureDetector(
                                key: dropdownKey,
                                onTap: _toggleDropdown,
                                child: Row(
                                  children: [
                                    const Text(
                                      'Admin',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black),
                                    ),
                                    Icon(
                                      isDropdownOpen
                                          ? Icons.arrow_drop_down
                                          : Icons.arrow_right,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 90),
                      // Stat Cards
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () =>
                                Navigator.pushNamed(context, '/employees'),
                            child: _buildStatCard(
                                'Employees', '250', Icons.people, Colors.green),
                          ),
                          GestureDetector(
                            onTap: () =>
                                Navigator.pushNamed(context, '/interview'),
                            child: _buildStatCard('Interviews', '150',
                                Icons.assignment, Colors.orange),
                          ),
                          _buildStatCard('Departments', '20', Icons.business,
                              Colors.purple),
                          _buildStatCard('Applicants', '120', Icons.person_add,
                              Colors.red),
                          _buildStatCard('Pending', '25', Icons.hourglass_empty,
                              Colors.grey),
                        ],
                      ),
                      const SizedBox(height: 26),
                      _buildGraphCard(screenWidth),
                    ],
                  ),
                  // Dropdown Positioned Below Admin Label
                  if (isDropdownOpen)
                    Positioned(
                      top: 60,
                      right: 20,
                      child: Material(
                        elevation: 4,
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                title: const Text('Profile'),
                                onTap: () {
                                  print('Profile clicked');
                                  setState(() {
                                    isDropdownOpen = false;
                                  });
                                },
                              ),
                              ListTile(
                                title: const Text('Settings'),
                                onTap: () {
                                  print('Settings clicked');
                                  setState(() {
                                    isDropdownOpen = false;
                                  });
                                },
                              ),
                              ListTile(
                                title: const Text('Logout'),
                                onTap: () {
                                  Navigator.pushReplacementNamed(context, '/');
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
      String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 5),
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
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 20),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGraphCard(double width) {
    return Container(
      width: width - 32,
      padding: const EdgeInsets.all(24),
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
          const Text(
            'Hires per month',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.only(
                bottom: 16.0), // Add padding to avoid overflow
            child: SizedBox(
              height: 300, // Ensure this height accommodates the graph
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 20,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: Colors.grey[200],
                        strokeWidth: 1,
                      );
                    },
                  ),
                  titlesData: FlTitlesData(
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 20,
                        reservedSize: 40,
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1,
                        getTitlesWidget: (value, meta) {
                          const months = [
                            'Jan',
                            'Feb',
                            'Mar',
                            'Apr',
                            'May',
                            'Jun',
                            'Jul',
                            'Aug',
                            'Sep',
                            'Oct',
                            'Nov',
                            'Dec'
                          ];
                          if (value.toInt() < months.length) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                months[value.toInt()],
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                              ),
                            );
                          }
                          return const Text('');
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: const [
                        FlSpot(0, 10),
                        FlSpot(1, 25),
                        FlSpot(2, 45),
                        FlSpot(3, 30),
                        FlSpot(4, 60),
                        FlSpot(5, 20),
                        FlSpot(6, 35),
                        FlSpot(7, 40),
                        FlSpot(8, 35),
                        FlSpot(9, 35),
                        FlSpot(10, 40),
                        FlSpot(11, 45),
                      ],
                      isCurved: true,
                      color: const Color(0xFF358873),
                      barWidth: 2,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        color: const Color(0xFF358873).withOpacity(0.1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
