import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:assistant/screens/add_product.dart'; // Import your Add Product Page
import 'package:assistant/screens/inventory_list.dart'; // Import your Inventory List Page
import 'package:assistant/screens/reports.dart'; // Import your Reports Page

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String _selectedRole = 'Retailer'; // Default role

  @override
  void initState() {
    super.initState();
    _loadRole();
  }

  // Load the saved role from SharedPreferences
  Future<void> _loadRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedRole = prefs.getString('user_role') ?? 'Retailer'; // Default to Retailer
    });
  }

  // Save the selected role to SharedPreferences
  Future<void> _saveRole(String role) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_role', role);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inventory Dashboard'),
        backgroundColor: Colors.deepPurple, // Custom AppBar color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Role Selection Section
            Text(
              'Select Your Role:',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: DropdownButton<String>(
                value: _selectedRole,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedRole = newValue!;
                    _saveRole(_selectedRole);
                  });
                },
                items: <String>['Retailer', 'Wholesaler']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                isExpanded: true,
                underline: SizedBox(), // Remove the underline
              ),
            ),
            SizedBox(height: 20),
            // Overview Section
            Text(
              'Welcome to Your Inventory App!',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Inventory Statistics:', // You can replace this with actual statistics
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                'Total Products: 150\nTotal Value: \shs5000.00', // Placeholder statistics
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            SizedBox(height: 30),
            // Navigation Buttons
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddProductPage()),
                );
              },
              child: Text('Add New Product'),
              style: ElevatedButton.styleFrom(
                disabledBackgroundColor: Colors.deepPurple,
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                minimumSize: Size(double.infinity, 50), // Full width button
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InventoryListPage()),
                );
              },
              child: Text('View Inventory List'),
              style: ElevatedButton.styleFrom(
                disabledBackgroundColor: Colors.deepPurple,
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                minimumSize: Size(double.infinity, 50), // Full width button
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReportsPage()),
                );
              },
              child: Text('View Reports'),
              style: ElevatedButton.styleFrom(
                disabledBackgroundColor: Colors.deepPurple,
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                minimumSize: Size(double.infinity, 50), // Full width button
              ),
            ),
          ],
        ),
      ),
    );
  }
}
