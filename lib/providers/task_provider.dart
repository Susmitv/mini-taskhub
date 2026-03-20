import 'package:flutter/material.dart';
import '../services/supabase_service.dart';

class TaskProvider extends ChangeNotifier {
  final service = SupabaseService();
  List tasks = [];

  Future<void> loadTasks() async {
    tasks = await service.fetchTasks();
    notifyListeners();
  }

  Future<void> addTask(String title) async {
    await service.addTask(title);
    await loadTasks();
  }

  Future<void> deleteTask(String id) async {
    await service.deleteTask(id);
    await loadTasks();
  }
  Future<void> toggleTask(String id, bool currentStatus) async {
    await service.toggleTask(id, currentStatus);
    await loadTasks(); // 🔥 this refreshes UI
  }
}