import 'package:flutter/material.dart';

void main() {
  runApp(const SnsApp());
}

class SnsApp extends StatelessWidget {
  const SnsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SNS App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    FeedScreen(),
    UploadScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SNS App'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Feed'),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_a_photo),
            label: 'Upload',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> posts = [
      {
        'username': 'travel_lover',
        'location': 'Seoul, Korea',
        'avatar': 'assets/images/user_avatar_1.jpg',
        'image': 'assets/images/sample_post_1.jpg',
        'likes': 245,
        'caption': '아름다운 서울의 봄날 🌸 #서울 #봄 #여행',
      },
      {
        'username': 'food_enthusiast',
        'location': 'Busan, Korea',
        'avatar': 'assets/images/user_avatar_2.jpg',
        'image': 'assets/images/sample_post_2.jpg',
        'likes': 189,
        'caption': '부산 해산물의 맛! 🦐 #부산 #해산물 #맛집',
      },
      {
        'username': 'nature_photographer',
        'location': 'Jeju Island',
        'avatar': 'assets/images/user_avatar_1.jpg',
        'image': 'assets/images/sample_post_3.jpg',
        'likes': 567,
        'caption': '제주도의 아름다운 자연 🌿 #제주 #자연 #사진',
      },
    ];

    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return Card(
          margin: const EdgeInsets.all(8.0),
          elevation: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User info with avatar
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(post['avatar']),
                  radius: 20,
                ),
                title: Text(
                  post['username'],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(post['location']),
                trailing: const Icon(Icons.more_vert),
              ),
              // Post image
              Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(post['image'], fit: BoxFit.cover),
                ),
              ),
              // Action buttons
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.favorite_border),
                          onPressed: () {},
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(Icons.comment_outlined),
                          onPressed: () {},
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(Icons.send_outlined),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.bookmark_border),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              // Likes count
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  '${post['likes']} likes',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              // Caption
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 16.0),
                child: RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: [
                      TextSpan(
                        text: '${post['username']} ',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: post['caption']),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class UploadScreen extends StatelessWidget {
  const UploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey[300]!, width: 2),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.cloud_upload_outlined,
                  size: 80,
                  color: Colors.grey[600],
                ),
                const SizedBox(height: 16),
                Text(
                  '사진을 업로드하세요',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          const Text(
            '갤러리에서 사진을 선택하여 공유하세요',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            onPressed: () {
              // TODO: Implement image picking functionality
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('이미지 선택 기능이 곧 추가됩니다!'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            icon: const Icon(Icons.add_photo_alternate_outlined),
            label: const Text('갤러리에서 선택'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              textStyle: const TextStyle(fontSize: 16),
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> profileImages = [
      'assets/images/sample_post_1.jpg',
      'assets/images/sample_post_2.jpg',
      'assets/images/sample_post_3.jpg',
      'assets/images/sample_post_1.jpg',
      'assets/images/sample_post_2.jpg',
      'assets/images/sample_post_3.jpg',
    ];

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          // Profile avatar
          CircleAvatar(
            radius: 50,
            backgroundImage: const AssetImage(
              'assets/images/profile_avatar.jpg',
            ),
            backgroundColor: Colors.grey[300],
          ),
          const SizedBox(height: 16),
          // Profile name and username
          const Text(
            '김플러터',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const Text(
            '@flutter_dev',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          const Text(
            'Flutter 개발자 | 모바일 앱 개발 중',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          // Stats
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatColumn('15', 'Posts'),
              _buildStatColumn('1.2k', 'Followers'),
              _buildStatColumn('500', 'Following'),
            ],
          ),
          const SizedBox(height: 20),
          // Edit profile button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  side: const BorderSide(color: Colors.grey),
                ),
                child: const Text(
                  '프로필 편집',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Posts grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: profileImages.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
            ),
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.asset(profileImages[index], fit: BoxFit.cover),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatColumn(String count, String label) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}
