import 'package:flutter/material.dart';
import 'package:monchi_ai_companion_app/features/chat/presentation/chat_page.dart';
import 'package:monchi_ai_companion_app/features/memory/presentation/memories_page.dart';
import 'package:monchi_ai_companion_app/features/settings/settings_page.dart';
// TODO: Create or import these pages as needed
// import 'package:monchi_ai_companion_app/features/dashboard/presentation/emotion_dashboard_page.dart';
// import 'package:monchi_ai_companion_app/features/profile/profile_page.dart';
// import 'package:monchi_ai_companion_app/features/about/about_page.dart';
// import 'package:monchi_ai_companion_app/features/feedback/ai_feedback_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    _MainHomeBody(),
    ChatPage(),
  ];

  void _onBottomNavTapped(int index) {
    if (index == 2) {
      Scaffold.of(context).openDrawer();
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to Mochi!'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.purple),
              child: Text('Mochi Advanced', style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Memories'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_) => const MemoriesPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.bar_chart),
              title: const Text('Communication Efficiency'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement or navigate to your analytics/dashboard page
                // Navigator.push(context, MaterialPageRoute(builder: (_) => const EmotionDashboardPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement or navigate to your profile page
                // Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfilePage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('About Mochi'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement or navigate to your about page
                // Navigator.push(context, MaterialPageRoute(builder: (_) => const AboutPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.feedback),
              title: const Text('AI Feedback'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement or navigate to your AI feedback page
                // Navigator.push(context, MaterialPageRoute(builder: (_) => const AiFeedbackPage()));
              },
            ),
          ],
        ),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onBottomNavTapped,
        selectedItemColor: Colors.purple,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'More'),
        ],
      ),
    );
  }
}

class _MainHomeBody extends StatelessWidget {
  const _MainHomeBody();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Greeting Section
          const Text(
            'Hey [UserName], I missed you 💕',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          // Mochi Avatar
          Center(
            child: GestureDetector(
              onTap: () {
                // Interact with Mochi
              },
              child: Image.asset('assets/images/mochi_avatar.png', height: 140),
            ),
          ),
          const SizedBox(height: 20),

          // Emotion Check-in
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('How are you feeling today?', style: TextStyle(fontSize: 18)),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _emojiButton('😊'),
                      _emojiButton('😔'),
                      _emojiButton('😠'),
                      _emojiButton('😴'),
                      _emojiButton('🤩'),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // Navigate to detailed emotion input
                      },
                      child: const Text('Tell Mochi More'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Mood Summary
          const Text(
            'You’ve been feeling joyful lately, keep it up!',
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 20),

          // Chat Button
          Center(
            child: ElevatedButton.icon(
              icon: const Icon(Icons.chat_bubble_outline),
              label: const Text('Talk to Mochi'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const ChatPage()));
              },
            ),
          ),
          const SizedBox(height: 20),

          // Affirmation
          const Text(
            '“You deserve love, even from yourself.”',
            style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16),
          ),
          const SizedBox(height: 20),

          // Emotional Analytics
          const Text(
            'This week’s mood: 🌈 60% Joy · 30% Calm · 10% Frustration',
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ],
      ),
    );
  }

  static Widget _emojiButton(String emoji) {
    return IconButton(
      onPressed: () {
        // Track emoji feedback
      },
      icon: Text(emoji, style: const TextStyle(fontSize: 24)),
    );
  }
}