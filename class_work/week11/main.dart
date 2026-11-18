import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '뭐 먹지?',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF9F8F6),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF9F8F6),
          elevation: 0,
          surfaceTintColor: Colors.transparent,
        ),
        useMaterial3: true,
      ),
      home: const MenuRouletteScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MenuData {
  final String name;
  final String category; 
  final String time;     
  final String infoTitle;
  final String infoContent;

  MenuData({
    required this.name,
    required this.category,
    required this.time,
    required this.infoTitle,
    required this.infoContent,
  });
}

class MenuRouletteScreen extends StatefulWidget {
  const MenuRouletteScreen({super.key});

  @override
  State<MenuRouletteScreen> createState() => _MenuRouletteScreenState();
}

class _MenuRouletteScreenState extends State<MenuRouletteScreen> {
  final List<bool> _selectedTime = [false, false]; 
  final List<bool> _selectedCategory = [false, false]; 

  MenuData? _recommendedMenu;
  bool _hasSearched = false;

  final List<MenuData> _menuList = [
    MenuData(
      name: '버터 간장계란밥', 
      category: '집밥', 
      time: '점심', 
      infoTitle: '💡 재료 및 상세 조리법', 
      infoContent: '재료: 밥 1공기, 특란 1개, 무염버터 1조각(10g), 식용유 1스푼, 부순 김가루 1줌\n소스: 진간장 1.5스푼, 참기름 1스푼, 통깨 0.5스푼, 소금 한 꼬집, 후추 약간\n\n1. 달궈진 팬에 식용유를 두르고 계란을 올려 소금 한 꼬집을 뿌린 뒤 반숙으로 굽습니다.\n2. 갓 지은 따뜻한 밥을 그릇에 담고 가운데에 버터 1조각을 숨겨 녹입니다.\n3. 진간장, 참기름, 통깨를 작은 볼에 섞어 양념장을 만듭니다.\n4. 밥 위에 반숙 계란을 올리고 양념장을 빙 둘러 뿌려줍니다.\n5. 후추를 톡톡 뿌리고 김가루를 올린 뒤, 노른자를 터뜨려 비벼 드세요.'
    ),
    MenuData(
      name: '참치치즈김치볶음밥', 
      category: '집밥', 
      time: '점심', 
      infoTitle: '💡 재료 및 상세 조리법', 
      infoContent: '재료: 밥 1공기, 참치 1캔(100g), 익은 신김치 1종이컵, 모짜렐라 치즈 1줌, 대파 1/2대, 양파 1/4개, 식용유 2스푼\n소스: 고추장 0.5스푼, 설탕 0.5스푼, 참기름 1스푼, 통깨 약간\n\n1. 대파와 양파를 송송 썰어 식용유 2스푼에 볶아 파기름을 냅니다.\n2. 잘게 썬 신김치와 설탕 0.5스푼을 넣어 신맛을 잡으며 볶습니다.\n3. 기름을 뺀 참치와 고추장 0.5스푼을 넣고 타지 않게 볶아줍니다.\n4. 밥 1공기를 넣고 섞으며 볶다가 참기름 1스푼을 두릅니다.\n5. 밥을 가운데로 모아 모짜렐라 치즈를 듬뿍 올리고 뚜껑을 덮어 1~2분간 녹여냅니다.'
    ),
    MenuData(
      name: '차돌된장찌개', 
      category: '집밥', 
      time: '저녁', 
      infoTitle: '💡 재료 및 상세 조리법', 
      infoContent: '재료: 차돌박이 150g, 찌개용 두부 1/2모, 애호박 1/3개, 양파 1/2개, 청양고추 2개, 홍고추 1개, 대파 1/2대, 팽이버섯 1/2봉지, 쌀뜨물 400ml\n소스: 시판 된장 2스푼, 고추장 0.5스푼, 다진 마늘 1스푼, 고춧가루 0.5스푼\n\n1. 냄비에 차돌박이를 넣고 중불에서 고기 기름이 충분히 나올 때까지 볶습니다.\n2. 쌀뜨물을 붓고 된장과 고추장을 체에 밭쳐 부드럽게 풀어줍니다.\n3. 국물이 끓어오르면 깍둑 썰기한 애호박, 양파, 다진 마늘, 고춧가루를 넣고 푹 끓입니다.\n4. 채소가 투명해지면 두부와 팽이버섯을 넣고 3분간 더 끓여줍니다.\n5. 마지막으로 썰어둔 청양고추, 홍고추, 대파를 넣고 한소끔 끓여 마무리합니다.'
    ),
    MenuData(
      name: '목살 김치찌개', 
      category: '집밥', 
      time: '저녁', 
      infoTitle: '💡 재료 및 상세 조리법', 
      infoContent: '재료: 돼지 목살 200g, 잘 익은 신김치 2종이컵, 찌개용 두부 1/2모, 대파 1대, 양파 1/2개, 청양고추 1개, 쌀뜨물 500ml, 식용유 1스푼\n소스: 국간장 1스푼, 고춧가루 1스푼, 다진 마늘 1스푼, 새우젓 0.5스푼, 후추 약간\n\n1. 냄비에 식용유를 두르고 목살을 넣어 후추를 살짝 뿌린 뒤 겉면이 노릇해지게 볶습니다.\n2. 썰어둔 양파와 신김치를 넣고 김치가 숨이 죽을 때까지 달달 볶아줍니다.\n3. 쌀뜨물을 붓고 국간장, 고춧가루, 다진 마늘을 넣어줍니다.\n4. 중약불에서 15분 이상 푹 끓여 고기와 김치의 깊은 맛을 우려냅니다.\n5. 새우젓으로 부족한 간을 맞추고, 두부, 대파, 청양고추를 얹어 5분 더 끓입니다.'
    ),
    MenuData(
      name: '짜장면 + 탕수육', 
      category: '배달', 
      time: '점심', 
      infoTitle: '🔥 최고의 사이드 꿀조합', 
      infoContent: '추천 사이드 메뉴:\n• 짜장면의 묵직함을 씻어줄 얼큰한 짬뽕 국물 추가\n• 아삭아삭한 단무지와 알싸한 생양파 듬뿍 세팅\n• 달콤한 탕수육을 콕 찍어 먹을 간장+고춧가루 특제 소스\n• 짜장면이 살짝 느끼해질 때쯤 고춧가루 톡톡 뿌리기'
    ),
    MenuData(
      name: '수제 돈카츠 정식', 
      category: '배달', 
      time: '점심', 
      infoTitle: '🔥 최고의 사이드 꿀조합', 
      infoContent: '추천 사이드 메뉴:\n• 든든하고 따끈한 국물의 미니 우동 추가\n• 입가심을 도와줄 얇게 채 썬 양배추 샐러드 듬뿍\n• 돈카츠의 기름기를 싹 잡아줄 생와사비나 불닭 소스 곁들이기'
    ),
    MenuData(
      name: '매운 닭발', 
      category: '배달', 
      time: '저녁', 
      infoTitle: '🔥 최고의 사이드 꿀조합', 
      infoContent: '추천 사이드 메뉴:\n• 매운맛을 싹 잡아줄 톡톡 튀는 날치알 주먹밥\n• 입안을 달래주는 부드러운 푸딩 계란찜\n• 매콤한 닭발을 푹 찍어 먹을 고소한 마요네즈 듬뿍'
    ),
    MenuData(
      name: '국물 떡볶이와 튀김', 
      category: '배달', 
      time: '저녁', 
      infoTitle: '🔥 최고의 사이드 꿀조합', 
      infoContent: '추천 사이드 메뉴:\n• 국물에 푹 찍어 먹을 바삭한 모둠 튀김 (김말이, 오징어 등)\n• 혀끝의 매운맛을 달달하게 달래줄 쿨피스\n• 남은 국물에 싹싹 비벼 먹는 든든한 참치마요 컵밥'
    ),
  ];

  void _recommendMenu() {
    if (!_selectedTime.contains(true) || !_selectedCategory.contains(true)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('시간대와 식사 방식을 모두 선택해주세요!', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          backgroundColor: Colors.blueGrey.shade700,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }

    String selectedTimeStr = _selectedTime[0] ? '점심' : '저녁';
    String selectedCategoryStr = _selectedCategory[0] ? '배달' : '집밥';

    List<MenuData> filteredList = _menuList.where((menu) {
      return menu.time == selectedTimeStr && menu.category == selectedCategoryStr;
    }).toList();

    setState(() {
      _hasSearched = true; 
      if (filteredList.isNotEmpty) {
        filteredList.shuffle();
        _recommendedMenu = filteredList.first;
      } else {
        _recommendedMenu = null;
      }
    });
  }

  void _resetSelection() {
    setState(() {
      _selectedTime[0] = false;
      _selectedTime[1] = false;
      _selectedCategory[0] = false;
      _selectedCategory[1] = false;
      _hasSearched = false; 
      _recommendedMenu = null;
    });
  }

  void _showFeatureReadySnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.indigo.shade400,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Widget _buildVisualizedContent(MenuData menu) {
    if (menu.category == '집밥' && menu.infoContent.contains('재료:')) {
      List<String> parts = menu.infoContent.split('\n\n');
      String topPart = parts[0]; 
      String recipePart = parts.length > 1 ? parts[1] : '';

      List<String> topLines = topPart.split('\n');
      String ingredientsStr = topLines[0].replaceAll('재료:', '').trim();
      String sauceStr = topLines.length > 1 ? topLines[1].replaceAll('소스:', '').trim() : '';

      List<String> ingredients = ingredientsStr.split(',').map((e) => e.trim()).toList();
      List<String> sauces = sauceStr.isNotEmpty ? sauceStr.split(',').map((e) => e.trim()).toList() : [];

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.shopping_basket_outlined, size: 18, color: Colors.orange.shade700),
              const SizedBox(width: 6),
              const Text('준비할 재료', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF4A4A4A))),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: ingredients.map((e) => Chip(
              label: Text(e, style: const TextStyle(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.w500)),
              backgroundColor: Colors.orange.shade50,
              side: BorderSide(color: Colors.orange.shade200),
              padding: EdgeInsets.zero,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            )).toList(),
          ),
          const SizedBox(height: 16),
          
          if (sauces.isNotEmpty) ...[
            Row(
              children: [
                Icon(Icons.opacity, size: 18, color: Colors.red.shade700),
                const SizedBox(width: 6),
                const Text('소스 및 양념', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF4A4A4A))),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: sauces.map((e) => Chip(
                label: Text(e, style: const TextStyle(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.w500)),
                backgroundColor: Colors.red.shade50,
                side: BorderSide(color: Colors.red.shade200),
                padding: EdgeInsets.zero,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              )).toList(),
            ),
            const SizedBox(height: 24),
          ],
          
          Row(
            children: [
              Icon(Icons.menu_book, size: 18, color: Colors.green.shade700),
              const SizedBox(width: 6),
              const Text('레시피', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF4A4A4A))),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black12),
            ),
            child: Text(recipePart, style: const TextStyle(fontSize: 15, height: 1.8, color: Color(0xFF555555))),
          ),
        ],
      );
    } else if (menu.category == '배달' && menu.infoContent.contains('추천 사이드 메뉴:')) {
      List<String> lines = menu.infoContent.split('\n')
          .where((line) => line.trim().startsWith('•'))
          .map((e) => e.replaceAll('•', '').trim())
          .toList();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.star_rounded, size: 20, color: Colors.amber.shade600),
              const SizedBox(width: 6),
              const Text('추천 사이드 꿀조합', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF4A4A4A))),
            ],
          ),
          const SizedBox(height: 12),
          ...lines.map((line) {
            return Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black12),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4, offset: const Offset(0, 2)),
                ],
              ),
              child: Text(
                line, 
                style: const TextStyle(fontSize: 15, height: 1.4, color: Color(0xFF555555), fontWeight: FontWeight.w600)
              ),
            );
          }).toList(),
        ],
      );
    }
    
    return Text(menu.infoContent, style: const TextStyle(fontSize: 15, height: 1.8, color: Color(0xFF555555)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('뭐 먹지? 🤤🍴', style: TextStyle(fontWeight: FontWeight.w900, color: Color(0xFF333333))),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_month, color: Color(0xFF555555)),
            onPressed: () => _showFeatureReadySnackbar('식사 캘린더 기능은 2차 출시에 업데이트됩니다!'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (!_hasSearched) ...[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('1. 시간대를 선택하세요', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF555555))),
                    const SizedBox(height: 12),
                    ToggleButtons(
                      isSelected: _selectedTime,
                      onPressed: (index) {
                        setState(() {
                          for (int i = 0; i < _selectedTime.length; i++) _selectedTime[i] = i == index;
                        });
                      },
                      borderRadius: BorderRadius.circular(12),
                      selectedColor: Colors.white,
                      fillColor: const Color(0xFF7A8B99),
                      color: const Color(0xFF888888),
                      borderColor: Colors.black12,
                      selectedBorderColor: const Color(0xFF7A8B99),
                      constraints: const BoxConstraints(minHeight: 55, minWidth: 140),
                      children: const [
                        Text('점심 ☀️', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)), 
                        Text('저녁 🌙', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))
                      ],
                    ),
                    const SizedBox(height: 50), 

                    const Text('2. 식사 방식을 선택하세요', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF555555))),
                    const SizedBox(height: 12),
                    ToggleButtons(
                      isSelected: _selectedCategory,
                      onPressed: (index) {
                        setState(() {
                          for (int i = 0; i < _selectedCategory.length; i++) _selectedCategory[i] = i == index;
                        });
                      },
                      borderRadius: BorderRadius.circular(12),
                      selectedColor: Colors.white,
                      fillColor: const Color(0xFF8D877A),
                      color: const Color(0xFF888888),
                      borderColor: Colors.black12,
                      selectedBorderColor: const Color(0xFF8D877A),
                      constraints: const BoxConstraints(minHeight: 55, minWidth: 140),
                      children: const [
                        Text('배달 🛵', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)), 
                        Text('집밥 🍳', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))
                      ],
                    ),
                  ],
                ),
              ),
              
              ElevatedButton.icon(
                onPressed: _recommendMenu,
                icon: const Icon(Icons.check_circle_outline),
                label: const Text('메뉴 추천받기', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4A4A4A),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
              ),
              const SizedBox(height: 20),
            ] 
            else ...[
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white, 
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black.withOpacity(0.05)),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 20, offset: const Offset(0, 10)),
                    ],
                  ),
                  child: _recommendedMenu != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _recommendedMenu!.category == '집밥' ? '🍳 오늘의 집밥 추천' : '🛵 오늘의 배달 추천', 
                              style: TextStyle(fontSize: 15, color: _recommendedMenu!.category == '집밥' ? Colors.orange.shade800 : Colors.blue.shade800, fontWeight: FontWeight.bold)
                            ),
                            const SizedBox(height: 12),
                            Text(
                              _recommendedMenu!.name,
                              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Color(0xFF333333)),
                              textAlign: TextAlign.center,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: Divider(color: Colors.black12),
                            ),
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF9F9F9),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: SingleChildScrollView(
                                  child: _buildVisualizedContent(_recommendedMenu!),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            
                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton.icon(
                                    onPressed: _resetSelection,
                                    icon: const Icon(Icons.refresh, color: Color(0xFF777777), size: 18),
                                    label: const Text('처음으로', style: TextStyle(color: Color(0xFF555555), fontWeight: FontWeight.bold)),
                                    style: OutlinedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(vertical: 14),
                                      side: const BorderSide(color: Colors.black12),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: _recommendMenu,
                                    icon: const Icon(Icons.casino, size: 18),
                                    label: const Text('다른 메뉴', style: TextStyle(fontWeight: FontWeight.bold)),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF4A4A4A),
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(vertical: 14),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                      elevation: 0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: TextButton.icon(
                                    onPressed: () => _showFeatureReadySnackbar('오늘의 식사로 캘린더에 기록되었습니다!'),
                                    icon: const Icon(Icons.edit_calendar, color: Colors.indigo, size: 18),
                                    label: const Text('식사 기록', style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold)),
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.indigo.shade50,
                                      padding: const EdgeInsets.symmetric(vertical: 12),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: TextButton.icon(
                                    onPressed: () => _showFeatureReadySnackbar('공유하기 템플릿 로딩 중...'),
                                    icon: const Icon(Icons.ios_share, color: Colors.deepOrange, size: 18),
                                    label: const Text('결과 공유', style: TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.bold)),
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.deepOrange.shade50,
                                      padding: const EdgeInsets.symmetric(vertical: 12),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      : const Center(child: Text('해당 조건에 일치하는 메뉴가 없어요!', style: TextStyle(color: Color(0xFF555555)))),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}