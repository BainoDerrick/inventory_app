import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:assistant/screens/dashboard.dart'; // Import your Dashboard Page

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? role = prefs.getString('user_role');

  runApp(MyApp(initialRole: role));
}

class MyApp extends StatelessWidget {
  final String? initialRole;

  const MyApp({super.key, this.initialRole});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inventory Management App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: initialRole == null ? DashboardPage() : DashboardPage(),
      debugShowCheckedModeBanner: false, // Hide the debug banner
    );
  }
}
