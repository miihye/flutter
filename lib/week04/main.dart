import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '4주차 과제 - 프로필 및 정보 카드',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('컴퓨터소프트웨어학과 프로필'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // AC1: 아바타, 이름, 전공이 머리말에 표시
              const HeaderSection(),
              const SizedBox(height: 24.0),
              
              // AC2: 정보 Card 세 개를 스크롤해 확인 (ListView.builder 사용)
              const Text(
                '주요 학습 과제',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12.0),
              const InfoCardsSection(),
              const SizedBox(height: 24.0),

              // AC3: 버튼을 누르면 SnackBar 표시
              const FeedbackSection(),
            ],
          ),
        ),
      ),
    );
  }
}

// AC1 구현 위젯 (Row, CircleAvatar, Text, Icon 조합)
class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.teal.shade50,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 32.0,
            backgroundColor: Colors.teal,
            child: Icon(Icons.person, size: 40.0, color: Colors.white),
          ),
          const SizedBox(width: 16.0),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '장미혜',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4.0),
              Text(
                '컴퓨터소프트웨어학과',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// AC2 구현 위젯 (ListView 이용해 Card 3개 스크롤)
class InfoCardsSection extends StatelessWidget {
  const InfoCardsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> cardsData = [
      {
        'title': 'Week 01 - Flutter 환경 설정',
        'desc': 'VS Code와 Flutter SDK 연동 및 첫 앱 실행',
        'icon': 'build'
      },
      {
        'title': 'Week 02 - 위젯 레이아웃 기초',
        'desc': 'Row, Column, Container를 활용한 화면 구성',
        'icon': 'widgets'
      },
      {
        'title': 'Week 03 - 상태 관리 및 이벤트',
        'desc': 'StatefulWidget과 버튼 이벤트를 통한 상호작용',
        'icon': 'touch_app'
      },
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cardsData.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 12.0),
          child: ListTile(
            leading: const Icon(Icons.class_, color: Colors.teal),
            title: Text(cardsData[index]['title']!),
            subtitle: Text(cardsData[index]['desc']!),
          ),
        );
      },
    );
  }
}

// AC3 구현 위젯 (ElevatedButton 누를 시 SnackBar 표시)
class FeedbackSection extends StatelessWidget {
  const FeedbackSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('4주차 실습 피드백이 성공적으로 전달되었습니다!'),
              duration: Duration(seconds: 2),
            ),
          );
        },
        icon: const Icon(Icons.send),
        label: const Text('피드백 보내기 (AC3)'),
      ),
    );
  }
}