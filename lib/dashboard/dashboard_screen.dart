import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../providers/task_provider.dart';
import '../auth/login_screen.dart';
import '../settings/settings_screen.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() =>
        Provider.of<TaskProvider>(context, listen: false).loadTasks());
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      // 🔥 APP BAR
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "TaskHub",
          style: TextStyle(color: theme.colorScheme.onBackground),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: theme.iconTheme.color),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SettingsScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.logout, color: theme.iconTheme.color),
            onPressed: () async {
              await Supabase.instance.client.auth.signOut();

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => LoginScreen()),
              );
            },
          ),
        ],
      ),

      // ➕ ADD TASK BUTTON
      floatingActionButton: FloatingActionButton(
        backgroundColor: theme.colorScheme.primary,
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: theme.cardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            ),
            builder: (context) {
              TextEditingController controller = TextEditingController();

              return Padding(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 16,
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Add Task",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),

                    SizedBox(height: 15),

                    TextField(
                      controller: controller,
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: "Enter your task...",
                      ),
                    ),

                    SizedBox(height: 15),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 2, // ✨ added polish
                        backgroundColor: theme.colorScheme.primary,
                        minimumSize: Size(double.infinity, 50),
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        final text = controller.text.trim();

                        if (text.isNotEmpty) {
                          provider.addTask(text);
                          Navigator.pop(context);
                        }
                      },
                      child: Text("Add Task"),
                    ),

                    SizedBox(height: 10),
                  ],
                ),
              );
            },
          );
        },
      ),

      // 📋 BODY
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            // 👋 Greeting
            Text(
              "Hello 👋",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onBackground,
              ),
            ),

            SizedBox(height: 5),

            Text(
              "Manage your daily tasks",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: theme.colorScheme.onBackground.withOpacity(0.6),
                fontSize: 14,
              ),
            ),

            SizedBox(height: 25),

            // 📋 Section Title
            Text(
              "Your Tasks",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onBackground,
              ),
            ),

            SizedBox(height: 5),
            Divider(thickness: 1), // ✨ added structure
            SizedBox(height: 10),

            // 🔽 Task List
            Expanded(
              child: provider.tasks.isEmpty
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.task_alt,
                      size: 70,
                      color: theme.colorScheme.onBackground.withOpacity(0.4),
                    ),
                    SizedBox(height: 12),
                    Text(
                      "No tasks yet",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "Tap + to add your first task",
                      style: TextStyle(
                        fontSize: 13,
                        color: theme.colorScheme.onBackground.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              )
                  : ListView.builder(
                itemCount: provider.tasks.length,
                itemBuilder: (_, i) {
                  final task = provider.tasks[i];

                  return AnimatedContainer(
                    duration: Duration(milliseconds: 250), // ✨ smooth animation
                    margin: EdgeInsets.only(bottom: 12),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        )
                      ],
                    ),
                    child: Row(
                      children: [

                        // ✅ CHECKBOX (improved)
                        Checkbox(
                          value: task['is_completed'] ?? false,
                          activeColor: theme.colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          onChanged: (value) {
                            provider.toggleTask(
                              task['id'],
                              task['is_completed'] ?? false,
                            );
                          },
                        ),

                        // 📄 TASK TEXT
                        Expanded(
                          child: Text(
                            task['title'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: theme.colorScheme.onSurface,
                              decoration: task['is_completed'] == true
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                        ),

                        // ❌ DELETE
                        IconButton(
                          icon: Icon(Icons.delete_outline, color: Colors.red),
                          onPressed: () {
                            provider.deleteTask(task['id']);
                          },
                        )
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}