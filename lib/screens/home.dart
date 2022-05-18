import 'package:flutter/material.dart';
import 'package:franchise/responsive/responsive_widget.dart';
import 'package:franchise/screens/add_lead.dart';
import 'package:franchise/screens/dashboard.dart';
import 'package:franchise/screens/leads_screen.dart';
import 'package:franchise/screens/profile.dart';
import 'package:franchise/screens/services.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  static final List<Widget> _options = <Widget>[
    const DashBoard(),
    LeadPage(),
    ServicePage(),
    const Profile()
  ];
  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
      ResponsiveWidget(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.transparent,
          elevation: 0,
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AddLeads()));
          },
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 4),
              shape: BoxShape.circle,
              color: const Color(0xFFd00657),
            ),
            child: const Icon(Icons.add, size: 40),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar( 
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: _onItemTap,
          elevation: 5,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.groups), label: 'Leads'),
            BottomNavigationBarItem(
                icon: Icon(Icons.home_repair_service_outlined), label: 'Service'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline), label: 'Profile'),
          ],
          unselectedItemColor: Colors.grey,
          selectedItemColor: const Color(0xFFd00657),
        ),
        builder: (context, constraints) {
          return _options.elementAt(_selectedIndex);
        }));
  }
}
