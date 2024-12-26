import 'package:dashboard/screens/job_listings_screen.dart';
import 'package:flutter/material.dart';
import 'login-page.dart';
import 'screens/admin_home_screen.dart';
import 'screens/employee_screen.dart';
import 'screens/interview_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dashboard App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/admin-home': (context) => const AdminHomeScreen(),
        '/employees': (context) => const EmployeeScreen(),
        '/interview': (context) => const InterviewScreen(),
        '/jobs': (context) => const JobListingsScreen(),
        // '/departments': (context) => DepartmentsScreen(),
        // '/applicants': (context) => ApplicantsScreen(),
        // '/pending': (context) => PendingScreen(),
      },
    );
  }
}
