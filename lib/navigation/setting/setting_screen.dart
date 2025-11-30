import 'package:flutter/material.dart';
import 'package:travel_hub/navigation/setting/widgets/settings_header.dart';
import 'package:travel_hub/navigation/setting/widgets/settings_list.dart';

class SettingScreen extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onToggleTheme;

  const SettingScreen({
    super.key,
    required this.isDarkMode,
    required this.onToggleTheme,
  });

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            SettingsHeader(
              isDarkMode: widget.isDarkMode,
              onToggleTheme: widget.onToggleTheme,
            ),
            const Expanded(child: SettingsList()),
          ],
        ),
      ),
    );
  }
}
