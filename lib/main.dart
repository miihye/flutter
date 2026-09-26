import 'package:flutter/material.dart';

void main() {
  runApp(const GoalLabApp());
}

class GoalLabApp extends StatelessWidget {
  const GoalLabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Goal Lab',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const GoalHomePage(),
    );
  }
}

class GoalItem {
  String title;
  bool isCompleted;

  GoalItem({required this.title, this.isCompleted = false});
}

class GoalHomePage extends StatefulWidget {
  const GoalHomePage({super.key});

  @override
  State<GoalHomePage> createState() => _GoalHomePageState();
}

class _GoalHomePageState extends State<GoalHomePage> {
  final TextEditingController _controller = TextEditingController();
  final List<GoalItem> _goals = [];
  String? _errorMessage;

  void _addGoal() {
    final text = _controller.text.trim();
    setState(() {
      if (text.isEmpty) {
        _errorMessage = '목표를 입력해주세요.';
      } else {
        _goals.add(GoalItem(title: text));
        _controller.clear();
        _errorMessage = null;
      }
    });
  }

  void _toggleGoal(int index) {
    setState(() {
      _goals[index].isCompleted = !_goals[index].isCompleted;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Week 03 Goal Lab'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: '새로운 목표 입력',
                      errorText: _errorMessage,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _addGoal,
                  child: const Text('추가'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _goals.isEmpty
                  ? const Center(child: Text('등록된 목표가 없습니다.'))
                  : ListView.builder(
                      itemCount: _goals.length,
                      itemBuilder: (context, index) {
                        final item = _goals[index];
                        return Card(
                          child: ListTile(
                            leading: Checkbox(
                              value: item.isCompleted,
                              onChanged: (_) => _toggleGoal(index),
                            ),
                            title: Text(
                              item.title,
                              style: TextStyle(
                                decoration: item.isCompleted
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                                color: item.isCompleted
                                    ? Colors.grey
                                    : Colors.black,
                              ),
                            ),
                          ),
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