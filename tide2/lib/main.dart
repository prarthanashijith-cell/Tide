import 'package:flutter/material.dart';

void main() {
  runApp(const TideApp());
}

class TideApp extends StatelessWidget {
  const TideApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tide',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1B2A4A)),
      ),
      home: const HomePage(),
    );
  }
}

class Task {
  String title;
  bool isDone;
  Color priority;

  Task({required this.title, this.isDone = false, this.priority = Colors.red});
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Task> tasks = [
    Task(title: 'Submit DBMS assignment', priority: Colors.red),
    Task(title: 'Call Amma - 6 PM', priority: Colors.orange),
    Task(title: 'Gym session', priority: Colors.green),
  ];

  void _toggleTask(int index) {
    setState(() {
      tasks[index].isDone = !tasks[index].isDone;
    });
  }

  void _addTask(String title, Color priority) {
    setState(() {
      tasks.add(Task(title: title, priority: priority));
    });
  }

  void _showAddTask() {
    String newTask = '';
    Color selectedColor = Colors.red;

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1B2A4A),
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setModalState) => Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                autofocus: true,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Task name',
                  labelStyle: TextStyle(color: Color(0xFFFFD700)),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFFFD700))),
                ),
                onChanged: (v) => newTask = v,
              ),
              const SizedBox(height: 12),
              Row(
                children: [Colors.red, Colors.orange, Colors.green].map((c) =>
                  GestureDetector(
                    onTap: () => setModalState(() => selectedColor = c),
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      width: 32, height: 32,
                      decoration: BoxDecoration(
                        color: c,
                        shape: BoxShape.circle,
                        border: selectedColor == c ? Border.all(color: Colors.white, width: 3) : null,
                      ),
                    ),
                  ),
                ).toList(),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFD700),
                  foregroundColor: const Color(0xFF1B2A4A),
                ),
                onPressed: () {
                  if (newTask.isNotEmpty) {
                    _addTask(newTask, selectedColor);
                    Navigator.pop(ctx);
                  }
                },
                child: const Text('Add Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int remaining = tasks.where((t) => !t.isDone).length;

    return Scaffold(
      backgroundColor: const Color(0xFF1B2A4A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B2A4A),
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Good morning ☀️', style: TextStyle(fontSize: 14, color: Color(0xFFFFD700))),
            const Text('Today', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
            Text('$remaining tasks remaining', style: const TextStyle(fontSize: 13, color: Colors.white60)),
          ],
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: tasks.length,
        itemBuilder: (ctx, i) => GestureDetector(
          onTap: () => _toggleTask(i),
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF243660),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  tasks[i].isDone ? Icons.check_circle : Icons.circle_outlined,
                  color: tasks[i].isDone ? const Color(0xFFFFD700) : Colors.white54,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    tasks[i].title,
                    style: TextStyle(
                      fontSize: 16,
                      decoration: tasks[i].isDone ? TextDecoration.lineThrough : null,
                      color: tasks[i].isDone ? Colors.white38 : Colors.white,
                    ),
                  ),
                ),
                Container(width: 10, height: 10, decoration: BoxDecoration(color: tasks[i].priority, shape: BoxShape.circle)),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTask,
        backgroundColor: const Color(0xFFFFD700),
        child: const Icon(Icons.add, color: Color(0xFF1B2A4A)),
      ),
    );
  }
}