import 'package:flutter/material.dart';

void main() {
  runApp(const NoticeApp());
}

class NoticeApp extends StatelessWidget {
  const NoticeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '비동기 공지 앱',
      // 수정된 부분: BlueColors -> Colors.blue로 변경
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const NoticeHomePage(),
    );
  }
}

class NoticeHomePage extends StatefulWidget {
  const NoticeHomePage({super.key});

  @override
  State<NoticeHomePage> createState() => _NoticeHomePageState();
}

class _NoticeHomePageState extends State<NoticeHomePage> {
  String _status = '대기 중';
  String _noticeText = '공지사항이 없습니다.';
  int _requestCount = 0;
  bool _isLoading = false;

  // 모의 비동기 공지 요청 함수 (Future 활용)
  Future<void> _fetchNotice({bool shouldFail = false}) async {
    if (_isLoading) return; // 중복 클릭 방지

    setState(() {
      _isLoading = true;
      _status = '로딩 중...';
      _requestCount++;
    });

    try {
      // 2초 지연 (네트워크 통신 모사)
      await Future.delayed(const Duration(seconds: 2));

      if (shouldFail) {
        throw Exception('네트워크 연결 실패');
      }

      setState(() {
        _isLoading = false;
        _status = '성공';
        _noticeText = '[공지] 6주차 비동기 과제 안내: 정상적으로 공지를 불러왔습니다.';
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _status = '실패';
        _noticeText = '오류 발생: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('비동기 공지 앱 (6주차)')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('상태: $_status', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text('요청 횟수: $_requestCount회', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.grey[200],
              child: Text(_noticeText, style: const TextStyle(fontSize: 16)),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: _isLoading ? null : () => _fetchNotice(shouldFail: false),
              child: const Text('공지 불러오기 (성공 시나리오)'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _isLoading ? null : () => _fetchNotice(shouldFail: true),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red[100]),
              child: const Text('공지 불러오기 (실패 시나리오)'),
            ),
          ],
        ),
      ),
    );
  }
}