import 'package:flutter/material.dart';
import 'package:travel_hub/constant.dart';
import 'package:travel_hub/navigation/hotels/hotels_screen.dart';
import 'package:travel_hub/navigation/home/home_screen.dart';
import 'package:travel_hub/navigation/maps/full_map_screen.dart';
import 'package:travel_hub/navigation/places/places_screen.dart';
import 'package:travel_hub/navigation/setting/setting_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static _MainScreenState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MainScreenState>();

  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    HotelsScreen(),
    PlacesScreen(),
    FullMapScreen(),
    SettingScreen(),
  ];

 
  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWide = size.width >= 600;

    return Scaffold(
      
      body: SafeArea(child: _pages[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: kBackgroundColor,
        unselectedItemColor: kGrey,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: isWide ? 14 : 12,
        unselectedFontSize: isWide ? 12 : 10,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.hotel), label: "Hotels"),
          BottomNavigationBarItem(icon: Icon(Icons.place), label: "Places"),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: "Map"),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}
