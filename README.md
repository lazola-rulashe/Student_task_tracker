# Student Task Tracker 📚

A simple mobile application built with Flutter that allows students to create tasks, keep track of assignments, and mark tasks as completed.

## Features

- **View tasks** - Display a list of tasks on the screen
- **Add tasks** - Enter a task using a text field and add it to the list
- **Complete tasks** - Tap a checkbox to mark a task as complete
- **Delete tasks** - Remove a task using a delete button
- **Task counter** - Display the number of tasks remaining
- **Save tasks** - Keep tasks available after closing the app (using shared_preferences)



## Technologies Used

- **Dart** - Programming language
- **Flutter** - Mobile UI framework
- **Material Design** - Prebuilt UI components
- **shared_preferences** - Local data persistence

## Getting Started

### Prerequisites

- Flutter SDK (3.0 or higher)
- Dart SDK
- Android Studio or VS Code
- Android Emulator or physical device

### Installation

1. Clone the repository:
```bash
git clone <your-repo-url>
cd student_task_tracker
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## Running Tests

The project includes unit tests for the Task model and widget tests for the UI:

```bash
flutter test
```

All tests should pass (15 tests total):
- 8 Task model tests
- 7 Widget tests

## Project Structure

```
student_task_tracker/
├── lib/
│   ├── main.dart           # Main app entry point and UI
│   └── models/
│       └── task.dart       # Task model class
├── test/
│   ├── models/
│   │   └── task_test.dart  # Task model unit tests
│   └── widget_test.dart    # Widget integration tests
└── pubspec.yaml            # Dependencies and metadata
```

## Usage

1. **Add a task**: Type in the text field and click the + button (or press Enter)
2. **Complete a task**: Tap the checkbox next to a task
3. **Delete a task**: Tap the delete icon next to a task
4. **View remaining tasks**: Check the counter at the top of the screen

## Data Persistence

Tasks are saved locally using the `shared_preferences` package. Your tasks will persist even after closing the app.

## Dart Concepts Practiced

This project demonstrates fundamental Dart concepts:
- Variables (store task names and completion status)
- Classes and objects (Task class)
- Lists (store multiple tasks)
- Functions (add, complete, delete tasks)
- Boolean values (track completion status)
- Conditional statements (display different content based on task status)
- Null safety (handle optional values safely)


