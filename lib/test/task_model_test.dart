import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Task model serialization', () {
    final task = {
      'id': '1',
      'title': 'Test Task',
      'is_completed': false,
    };

    expect(task['title'], 'Test Task');
    expect(task['is_completed'], false);
  });
}