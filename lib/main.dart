import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/task.dart';

void main() {
  runApp(const StudentTaskTrackerApp());
}

class StudentTaskTrackerApp extends StatelessWidget {
  const StudentTaskTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Task Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const TaskListScreen(),
    );
  }
}

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final List<Task> _tasks = [];
  final TextEditingController _taskController = TextEditingController();
  final List<String> _taskIds = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final taskIds = prefs.getStringList('task_ids') ?? [];
    
    setState(() {
      _taskIds.clear();
      _taskIds.addAll(taskIds);
      _tasks.clear();
      
      for (final id in taskIds) {
        final taskJson = prefs.getString('task_$id');
        if (taskJson != null) {
          final task = Task.fromJson({
            'id': id,
            'title': prefs.getString('task_${id}_title') ?? '',
            'isCompleted': prefs.getBool('task_${id}_completed') ?? false,
          });
          _tasks.add(task);
        }
      }
    });
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    
    await prefs.setStringList('task_ids', _taskIds);
    
    for (final task in _tasks) {
      await prefs.setString('task_${task.id}_title', task.title);
      await prefs.setBool('task_${task.id}_completed', task.isCompleted);
    }
  }

  void _addTask() {
    final title = _taskController.text.trim();
    if (title.isEmpty) return;

    final id = DateTime.now().millisecondsSinceEpoch.toString();
    final newTask = Task(id: id, title: title);

    setState(() {
      _tasks.add(newTask);
      _taskIds.add(id);
      _taskController.clear();
    });

    _saveTasks();
  }

  void _toggleTaskCompletion(int index) {
    setState(() {
      _tasks[index] = _tasks[index].copyWith(
        isCompleted: !_tasks[index].isCompleted,
      );
    });

    _saveTasks();
  }

  void _deleteTask(int index) {
    final taskId = _tasks[index].id;
    
    setState(() {
      _tasks.removeAt(index);
      _taskIds.remove(taskId);
    });

    _saveTasks();
  }

  int get _remainingTasks {
    return _tasks.where((task) => !task.isCompleted).length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('My Tasks 📚'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text(
                  'Stay productive!',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                Text(
                  'Tasks remaining: $_remainingTasks',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _tasks.isEmpty
                ? const Center(
                    child: Text(
                      'No tasks yet. Add one below!',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: _tasks.length,
                    itemBuilder: (context, index) {
                      final task = _tasks[index];
                      return ListTile(
                        leading: Checkbox(
                          value: task.isCompleted,
                          onChanged: (bool? value) {
                            _toggleTaskCompletion(index);
                          },
                        ),
                        title: Text(
                          task.title,
                          style: TextStyle(
                            decoration: task.isCompleted
                                ? TextDecoration.lineThrough
                                : null,
                            color: task.isCompleted ? Colors.grey : null,
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteTask(index),
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: const InputDecoration(
                      hintText: 'Enter a new task...',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _addTask(),
                  ),
                ),
                const SizedBox(width: 8),
                FloatingActionButton(
                  onPressed: _addTask,
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }
}
