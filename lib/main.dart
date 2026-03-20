import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provider/provider.dart';

import 'auth/login_screen.dart';
import 'dashboard/dashboard_screen.dart';
import 'providers/task_provider.dart';
import 'providers/theme_provider.dart';
import 'app/theme.dart';
import 'config/supabase_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: SupabaseConfig.url,
    anonKey: SupabaseConfig.anonKey,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'TaskHub',

            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme, // ✅ only one

            themeMode: themeProvider.currentTheme,

            home: user == null ? LoginScreen() : DashboardScreen(),
          );
        },
      ),
    );
  }
}