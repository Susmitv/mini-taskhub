import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Dark Mode",
                  style: TextStyle(fontSize: 16),
                ),

                Switch(
                  value: themeProvider.isDark,
                  onChanged: (value) {
                    themeProvider.toggleTheme();
                  },
                )
              ],
            ),

          ],
        ),
      ),
    );
  }
}