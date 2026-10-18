import 'package:flutter/material.dart';

void main() {
  runApp(const Week05App());
}

class Week05App extends StatelessWidget {
  const Week05App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '5주차 과제 - 상태 기능',
      theme: ThemeData(primarySwatch: Colors.indigo, useMaterial3: true),
      home: const TaskContextScreen(),
    );
  }
}

// 1. 데이터 모델 (원본 상태 정의)
class TaskItem {
  final String id;
  final String title;
  bool isDone;

  TaskItem({required this.id, required this.title, this.isDone = false});
}

class TaskContextScreen extends StatefulWidget {
  const TaskContextScreen({super.key});

  @override
  State<TaskContextScreen> createState() => _TaskContextScreenState();
}

class _TaskContextScreenState extends State<TaskContextScreen> {
  // AC1: 초기 상태 정의
  final List<TaskItem> _tasks = [
    TaskItem(id: '1', title: '5주차 과제 컨텍스트 작성', isDone: false),
    TaskItem(id: '2', title: 'Flutter 상태 기능 구현', isDone: false),
    TaskItem(id: '3', title: 'PROMPT_COMPARISON 결과 관찰', isDone: false),
  ];

  // AC4: 계산 가능한 값을 원본 상태로 별도 저장하지 않고 getter로 즉시 계산
  int get completedCount => _tasks.where((t) => t.isDone).length;

  // AC2, AC3: 토글(완료 ↔ 취소/원복) 동작 처리
  void _toggleTask(int index) {
    setState(() {
      _tasks[index].isDone = !_tasks[index].isDone;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('컴퓨터소프트웨어학과 - 장미혜'),
        backgroundColor: Colors.indigo.shade100,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 머리말: 학과 및 학번 정보
            const Text(
              '학번: 2025136004 | 5주차 상태 관리 실습',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            
            // 상태 계산값 표시 카드 (AC4 검증 영역)
            Card(
              color: Colors.indigo.shade50,
              child: ListTile(
                leading: const Icon(Icons.analytics, color: Colors.indigo),
                title: Text('진행 현황: 총 ${_tasks.length}개 중 $completedCount개 완료'),
                subtitle: Text('달성률: ${(completedCount / _tasks.length * 100).toStringAsFixed(0)}%'),
              ),
            ),
            const SizedBox(height: 16),
            
            const Text(
              '작업 목록 (클릭하여 완료/취소 토글)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // AC1~AC3: 상태 변경 및 원복이 반영되는 리스트
            Expanded(
              child: ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  final task = _tasks[index];
                  return Card(
                    child: CheckboxListTile(
                      title: Text(
                        task.title,
                        style: TextStyle(
                          decoration: task.isDone
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          color: task.isDone ? Colors.grey : Colors.black,
                        ),
                      ),
                      value: task.isDone,
                      onChanged: (_) => _toggleTask(index), // 상태 변경 이벤트
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