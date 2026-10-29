import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_task_tracker/main.dart';

void main() {
  group('Student Task Tracker Widget Tests', () {
    testWidgets('App should display title and empty state message',
        (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});

      await tester.pumpWidget(const StudentTaskTrackerApp());

      expect(find.text('My Tasks 📚'), findsOneWidget);
      expect(find.text('Stay productive!'), findsOneWidget);
      expect(find.text('Tasks remaining: 0'), findsOneWidget);
      expect(find.text('No tasks yet. Add one below!'), findsOneWidget);
    });

    testWidgets('Should display task counter when tasks are added',
        (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});

      await tester.pumpWidget(const StudentTaskTrackerApp());

      expect(find.text('Tasks remaining: 0'), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'Complete Flutter practical');
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      expect(find.text('Tasks remaining: 1'), findsOneWidget);
      expect(find.text('Complete Flutter practical'), findsOneWidget);
    });

    testWidgets('Should not add empty task', (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});

      await tester.pumpWidget(const StudentTaskTrackerApp());

      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      expect(find.text('Tasks remaining: 0'), findsOneWidget);
      expect(find.text('No tasks yet. Add one below!'), findsOneWidget);
    });

    testWidgets('Should toggle task completion', (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});

      await tester.pumpWidget(const StudentTaskTrackerApp());

      await tester.enterText(find.byType(TextField), 'Study Dart functions');
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      expect(find.text('Tasks remaining: 1'), findsOneWidget);

      await tester.tap(find.byType(Checkbox));
      await tester.pumpAndSettle();

      expect(find.text('Tasks remaining: 0'), findsOneWidget);
    });

    testWidgets('Should delete task', (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});

      await tester.pumpWidget(const StudentTaskTrackerApp());

      await tester.enterText(find.byType(TextField), 'Write unit tests');
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      expect(find.text('Tasks remaining: 1'), findsOneWidget);
      expect(find.text('Write unit tests'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.delete));
      await tester.pumpAndSettle();

      expect(find.text('Tasks remaining: 0'), findsOneWidget);
      expect(find.text('No tasks yet. Add one below!'), findsOneWidget);
    });

    testWidgets('Should add task via Enter key', (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});

      await tester.pumpWidget(const StudentTaskTrackerApp());

      await tester.enterText(find.byType(TextField), 'Test task');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      expect(find.text('Tasks remaining: 1'), findsOneWidget);
      expect(find.text('Test task'), findsOneWidget);
    });

    testWidgets('Should display completed tasks with strikethrough',
        (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});

      await tester.pumpWidget(const StudentTaskTrackerApp());

      await tester.enterText(find.byType(TextField), 'Review Git commands');
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      final textWidget = tester.widget<Text>(find.text('Review Git commands'));
      expect(textWidget.style?.decoration, isNull);

      await tester.tap(find.byType(Checkbox));
      await tester.pumpAndSettle();

      final completedTextWidget =
          tester.widget<Text>(find.text('Review Git commands'));
      expect(completedTextWidget.style?.decoration, TextDecoration.lineThrough);
    });
  });
}
