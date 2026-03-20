import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final supabase = Supabase.instance.client;

  Future<List> fetchTasks() async {
    return await supabase.from('tasks').select().order('created_at');
  }

  Future<void> addTask(String title) async {
    try {
      final user = supabase.auth.currentUser;

      print("USER: $user"); // 👈 ADD THIS

      await supabase.from('tasks').insert({
        'title': title,
        'user_id': user!.id,
        'is_completed': false,
      });

      print("TASK ADDED SUCCESSFULLY"); // 👈 ADD THIS

    } catch (e) {
      print("ERROR ADDING TASK: $e"); // 👈 ADD THIS
    }
  }

  Future<void> deleteTask(String id) async {
    await supabase.from('tasks').delete().eq('id', id);
  }
  Future<void> toggleTask(String id, bool currentStatus) async {
    await supabase
        .from('tasks')
        .update({'is_completed': !currentStatus})
        .eq('id', id);
  }
}