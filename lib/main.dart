import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'tasks.dart';
import 'style_button.dart';
import 'style_text.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: TodoList(),
  ));
}

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  TextEditingController c = TextEditingController();
  List<Map<String, dynamic>> tasks = [];

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  @override
  void dispose() {
    c.dispose();
    super.dispose();
  }

  void todo() {
    final task = c.text.trim();
    if (task.isNotEmpty) {
      setState(() {
        tasks.add({'text': task, 'done': false});
        c.clear();
      });
      saveTasks();
    }
  }

  void delete(int index) {
    setState(() {
      tasks.removeAt(index);
    });
    saveTasks();
  }

  void done(int index) {
    setState(() {
      tasks[index]['done'] = !tasks[index]['done'];
    });
    saveTasks();
  }

  Future<void> saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final data = jsonEncode(tasks);
    await prefs.setString('tasks', data);
  }

  Future<void> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('tasks');
    if (data != null) {
      setState(() {
        tasks = List<Map<String, dynamic>>.from(jsonDecode(data));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFF8E1),
      appBar: AppBar(
        backgroundColor: const Color(0xffFFB300),
        title: const Text(
          '📝 TODO LIST',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: c,
              decoration: InputDecoration(
                labelText: 'Add a new task',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              style: const TextStyle(fontSize: 18),
              onSubmitted: (_) => todo(),
            ),
            const SizedBox(height: 10),
            StyleButton(onPressed: todo, child: const StyleText('Add')),
            const SizedBox(height: 20),
            Expanded(
              child: tasks.isEmpty
                  ? const Center(child: Text("No tasks yet..."))
                  : ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        final task = tasks[index];
                        final isDone = task['done'];
                        return Tasks(
                          child: task['text'],
                          isDone: isDone,
                          onPressed: () => delete(index),
                          text: 'Delete',
                          onPressed2: () => done(index),
                          text2: isDone ? 'Undo' : 'Done',
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
