import 'package:flutter/material.dart';

class JobListScreen extends StatelessWidget {
  const JobListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> jobs = [
      {
        'jobTitle': 'HR Manager',
        'jobDescription': 'Responsible for managing HR tasks and policies.',
        'position': 'Manager',
        'availability': 'Full-Time',
        'location': 'San Francisco, CA',
      },
      {
        'jobTitle': 'Assistant Professor',
        'jobDescription': 'Teach undergraduate students and conduct research.',
        'position': 'Professor',
        'availability': 'Part-Time',
        'location': 'New York, NY',
      },
      {
        'jobTitle': 'Software Developer',
        'jobDescription': 'Develop and maintain web applications.',
        'position': 'Developer',
        'availability': 'Full-Time',
        'location': 'Seattle, WA',
      },
      {
        'jobTitle': 'Marketing Specialist',
        'jobDescription': 'Plan and execute marketing strategies.',
        'position': 'Specialist',
        'availability': 'Part-Time',
        'location': 'Chicago, IL',
      },
      {
        'jobTitle': 'Data Analyst',
        'jobDescription': 'Analyze complex datasets and provide insights.',
        'position': 'Analyst',
        'availability': 'Full-Time',
        'location': 'Austin, TX',
      },
      {
        'jobTitle': 'Project Manager',
        'jobDescription': 'Oversee and manage multiple projects.',
        'position': 'Manager',
        'availability': 'Part-Time',
        'location': 'Los Angeles, CA',
      },
      {
        'jobTitle': 'Graphic Designer',
        'jobDescription': 'Create visual concepts for branding.',
        'position': 'Designer',
        'availability': 'Full-Time',
        'location': 'Miami, FL',
      },
      {
        'jobTitle': 'DevOps Engineer',
        'jobDescription': 'Optimize and automate development processes.',
        'position': 'Engineer',
        'availability': 'Full-Time',
        'location': 'Denver, CO',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Jobs"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Align(
            alignment: Alignment.center,
            child: Wrap(
              spacing: 16, // Horizontal spacing between cards
              runSpacing: 16, // Vertical spacing between cards
              children: jobs
                  .map((job) => _buildJobCard(
                        job: job,
                        context: context,
                      ))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildJobCard({
    required Map<String, String> job,
    required BuildContext context,
  }) {
    return SizedBox(
      width: 250, // Same width as the Forms
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: Colors.green[100],
                radius: 32,
                child: const Icon(
                  Icons.work,
                  size: 32,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                job['jobTitle'] ?? '',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                job['jobDescription'] ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 8),
              Text(
                'Availability: ${job['availability'] ?? ''}',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              Text(
                'Location: ${job['location'] ?? ''}',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    _viewJobDetails(context, job);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "View",
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _viewJobDetails(BuildContext context, Map<String, String> job) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(job['jobTitle'] ?? 'Job Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Description:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(job['jobDescription'] ?? ''),
              const SizedBox(height: 16),
              const Text(
                'Position:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(job['position'] ?? ''),
              const SizedBox(height: 16),
              const Text(
                'Availability:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(job['availability'] ?? ''),
              const SizedBox(height: 16),
              const Text(
                'Location:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(job['location'] ?? ''),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
