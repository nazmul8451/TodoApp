import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});
  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  List<Map<String, dynamic>> tasks = [];
  List<Map<String, dynamic>> categories = [
    {'title': 'Personal', 'count': 5, 'color': Colors.pink, 'icon': Icons.brush},
    {'title': 'Study', 'count': 3, 'color': Colors.blue, 'icon': Icons.menu_book},
    // {'title': 'Work', 'count': 7, 'color': Colors.orange, 'icon': Icons.work},
  ];

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  Future<void> saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final taskList = tasks.map((task) => jsonEncode(task)).toList();
    await prefs.setStringList('tasks', taskList);
  }

  Future<void> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final taskList = prefs.getStringList('tasks') ?? [];
    setState(() {
      tasks = taskList.map((t) => jsonDecode(t)).cast<Map<String, dynamic>>().toList();
    });
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'High':
        return Colors.red;
      case 'Medium':
        return Colors.orange;
      case 'Low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  void addTask(String task, String categoryTitle, String priority) {
    setState(() {
      tasks.add({
        'task': task,
        'completed': false,
        'category': categoryTitle,
        'priority': priority,
      });
    });
    saveTasks();
  }

  void editTask(int index, String updatedText) {
    setState(() {
      tasks[index]['task'] = updatedText;
    });
    saveTasks();
  }

  void toggleTaskStatus(int index) {
    setState(() {
      tasks[index]['completed'] = !tasks[index]['completed'];
    });
    saveTasks();
  }

  void deleteTask(int index) {
    final deletedTask = tasks[index];
    setState(() {
      tasks.removeAt(index);
    });
    saveTasks();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Task deleted"),
        duration: Duration(seconds: 3),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            setState(() {
              tasks.insert(index, deletedTask);
            });
            saveTasks();
          },
        ),
      ),
    );
  }

  void showTaskDialog({int? index}) {
    final TextEditingController taskController = TextEditingController();
    String selectedCategory = categories.first['title'];
    String selectedPriority = 'Medium';

    if (index != null) {
      taskController.text = tasks[index]['task'];
      selectedCategory = tasks[index]['category'];
      selectedPriority = tasks[index]['priority'];
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(index == null ? 'Add Task' : 'Edit Task'),
        content: StatefulBuilder(
          builder: (context, setInnerState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: taskController,
                  decoration: InputDecoration(hintText: 'Enter your task'),
                ),
                SizedBox(height: 16),
                DropdownButton<String>(
                  value: selectedCategory,
                  isExpanded: true,
                  items: categories.map((cat) {
                    return DropdownMenuItem<String>(
                      value: cat['title'],
                      child: Text(cat['title']),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setInnerState(() {
                        selectedCategory = value;
                      });
                    }
                  },
                ),
                SizedBox(height: 12),
                DropdownButton<String>(
                  value: selectedPriority,
                  isExpanded: true,
                  items: ['High', 'Medium', 'Low'].map((level) {
                    return DropdownMenuItem<String>(
                      value: level,
                      child: Text(level),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setInnerState(() {
                        selectedPriority = value;
                      });
                    }
                  },
                ),
              ],
            );
          },
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
          TextButton(
            onPressed: () {
              final text = taskController.text.trim();
              if (text.isNotEmpty) {
                if (index == null) {
                  addTask(text, selectedCategory, selectedPriority);
                } else {
                  editTask(index, text);
                }
                Navigator.pop(context);
              }
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  void showAddCategoryDialog() {
    final TextEditingController catController = TextEditingController();
    Color selectedColor = Colors.deepPurple;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New Category'),
        content: TextField(
          controller: catController,
          decoration: InputDecoration(hintText: 'Enter category name'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
          TextButton(
            onPressed: () {
              final title = catController.text.trim();
              if (title.isNotEmpty) {
                setState(() {
                  categories.add({
                    'title': title,
                    'count': 0,
                    'color': selectedColor,
                    'icon': Icons.category,
                  });
                });
              }
              Navigator.pop(context);
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }
  Widget _buildTaskItem(Map<String, dynamic> task, int index) {
    return Dismissible(
      key: ValueKey(index),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => deleteTask(index),
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 20),
        color: Colors.redAccent,
        child: Icon(Icons.delete, color: Colors.white),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: _getPriorityColor(task['priority']).withOpacity(0.15),
              child: Icon(Icons.checklist, color: _getPriorityColor(task['priority'])),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task['task'],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      decoration: task['completed'] ? TextDecoration.lineThrough : null,
                      color: task['completed'] ? Colors.grey : Colors.black,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "${task['category']} • ${task['priority']} Priority",
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => toggleTaskStatus(index),
              child: Icon(
                task['completed'] ? Icons.check_circle : Icons.radio_button_unchecked,
                color: task['completed'] ? Colors.green : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(String title, int count, Color color, IconData icon) {
    return Container(
      width: 160,
      margin: EdgeInsets.only(right: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: color.withOpacity(0.2),
            child: Icon(icon, color: color, size: 20),
          ),
          SizedBox(height: 12),
          Flexible(
            child: Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(height: 6),
          Text(
            "$count Tasks",
            style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "What's up, Idiot!",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(icon: Icon(Icons.search, color: Colors.grey), onPressed: () {}),
          IconButton(icon: Icon(Icons.notifications_none, color: Colors.grey), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 150,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  ...categories.map((cat) => _buildCategoryCard(
                    cat['title'],
                    cat['count'],
                    cat['color'],
                    cat['icon'],
                  )),
                  GestureDetector(
                    onTap: showAddCategoryDialog,
                    child: Container(
                      width: 120,
                      margin: EdgeInsets.only(right: 12),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(child: Icon(Icons.add, size: 30)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              children: [
                SizedBox(height: 20),
                Text("Today's Tasks", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 12),
                ...tasks.asMap().entries.map((entry) {
                  int index = entry.key;
                  var task = entry.value;
                  return _buildTaskItem(task, index);
                }).toList(),
                SizedBox(height: 80),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        child: Icon(Icons.add, size: 30, color: Colors.white),
        onPressed: () => showTaskDialog(),
      ),
    );
  }
}
