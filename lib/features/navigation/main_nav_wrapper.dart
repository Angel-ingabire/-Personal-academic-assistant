import 'package:flutter/material.dart';

import '../announcements/screens/announcements_screen.dart';
import '../assignments/screens/assignment_list_screen.dart';
import '../dashboard/screens/dashboard_screen.dart';
import '../risk_status/screens/your_risk_status_screen.dart';
import '../schedule/screens/schedule_screen.dart';

/// Main navigation wrapper with BottomNavigationBar.
///
/// Tabs: Dashboard, Assignments, Schedule, Announcements, Your Risk Status.
class MainNavWrapper extends StatefulWidget {
  const MainNavWrapper({super.key});

  @override
  State<MainNavWrapper> createState() => _MainNavWrapperState();
}

class _MainNavWrapperState extends State<MainNavWrapper> {
  int _currentIndex = 0;

  late final List<Widget> _screens = [
    const DashboardScreen(),
    const AssignmentListScreen(),
    const ScheduleScreen(),
    const AnnouncementsScreen(),
    const YourRiskStatusScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_outlined),
            activeIcon: Icon(Icons.assignment),
            label: 'Assignments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            activeIcon: Icon(Icons.calendar_today),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.campaign_outlined),
            activeIcon: Icon(Icons.campaign),
            label: 'Announcements',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.warning_amber_outlined),
            activeIcon: Icon(Icons.warning_amber),
            label: 'Risk Status',
          ),
        ],
      ),
    );
  }
}
