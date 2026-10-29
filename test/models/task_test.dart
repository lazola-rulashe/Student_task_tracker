import 'package:flutter_test/flutter_test.dart';
import 'package:student_task_tracker/models/task.dart';

void main() {
  group('Task Model Tests', () {
    test('Task should be created with required parameters', () {
      final task = Task(
        id: '1',
        title: 'Complete Flutter practical',
      );

      expect(task.id, '1');
      expect(task.title, 'Complete Flutter practical');
      expect(task.isCompleted, false);
    });

    test('Task should be created with isCompleted set to true', () {
      final task = Task(
        id: '2',
        title: 'Study Dart functions',
        isCompleted: true,
      );

      expect(task.id, '2');
      expect(task.title, 'Study Dart functions');
      expect(task.isCompleted, true);
    });

    test('Task copyWith should create a new task with updated values', () {
      final originalTask = Task(
        id: '1',
        title: 'Original task',
        isCompleted: false,
      );

      final updatedTask = originalTask.copyWith(
        title: 'Updated task',
        isCompleted: true,
      );

      expect(updatedTask.id, '1');
      expect(updatedTask.title, 'Updated task');
      expect(updatedTask.isCompleted, true);
      expect(originalTask.title, 'Original task');
      expect(originalTask.isCompleted, false);
    });

    test('Task copyWith should preserve original values when not provided', () {
      final originalTask = Task(
        id: '1',
        title: 'Original task',
        isCompleted: false,
      );

      final copiedTask = originalTask.copyWith();

      expect(copiedTask.id, originalTask.id);
      expect(copiedTask.title, originalTask.title);
      expect(copiedTask.isCompleted, originalTask.isCompleted);
    });

    test('Task toJson should convert task to Map', () {
      final task = Task(
        id: '1',
        title: 'Write unit tests',
        isCompleted: true,
      );

      final json = task.toJson();

      expect(json['id'], '1');
      expect(json['title'], 'Write unit tests');
      expect(json['isCompleted'], true);
    });

    test('Task fromJson should create task from Map', () {
      final json = {
        'id': '2',
        'title': 'Review Git commands',
        'isCompleted': false,
      };

      final task = Task.fromJson(json);

      expect(task.id, '2');
      expect(task.title, 'Review Git commands');
      expect(task.isCompleted, false);
    });

    test('Task fromJson should handle missing isCompleted field', () {
      final json = {
        'id': '3',
        'title': 'Test task',
      };

      final task = Task.fromJson(json);

      expect(task.id, '3');
      expect(task.title, 'Test task');
      expect(task.isCompleted, false);
    });

    test('Task fromJson should handle null isCompleted field', () {
      final json = {
        'id': '4',
        'title': 'Another test',
        'isCompleted': null,
      };

      final task = Task.fromJson(json);

      expect(task.id, '4');
      expect(task.title, 'Another test');
      expect(task.isCompleted, false);
    });
  });
}
