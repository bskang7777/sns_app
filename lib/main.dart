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
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Feed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_a_photo),
            label: 'Upload',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10, // Display 10 placeholder posts
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Placeholder for user info
              const ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                title: Text('username'),
                subtitle: Text('Location'),
              ),
              // Placeholder for post image
              Container(
                height: 250,
                color: Colors.grey[300],
                child: const Center(child: Text('Post Image')),
              ),
              // Placeholder for action buttons
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.favorite_border),
                        SizedBox(width: 10),
                        Icon(Icons.comment_outlined),
                        SizedBox(width: 10),
                        Icon(Icons.send_outlined),
                      ],
                    ),
                    Icon(Icons.bookmark_border),
                  ],
                ),
              ),
              // Placeholder for likes and caption
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Text('100 likes', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(12.0, 4.0, 12.0, 12.0),
                child: Text('This is a caption for the post.'),
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
          const Icon(Icons.cloud_upload_outlined, size: 100, color: Colors.grey),
          const SizedBox(height: 20),
          const Text('Upload Your Photo', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          const Text('Select a photo from your gallery to share.', textAlign: TextAlign.center, style: TextStyle(fontSize: 16, color: Colors.grey)),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            onPressed: () {
              // TODO: Implement image picking functionality
            },
            icon: const Icon(Icons.add_photo_alternate_outlined),
            label: const Text('Select from Gallery'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              textStyle: const TextStyle(fontSize: 16),
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
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          const CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey,
            child: Icon(Icons.person, size: 50, color: Colors.white),
          ),
          const SizedBox(height: 10),
          const Text('Your Name', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const Text('@yourusername', style: TextStyle(fontSize: 16, color: Colors.grey)),
          const SizedBox(height: 20),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text('100', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text('Posts', style: TextStyle(color: Colors.grey)),
                ],
              ),
              Column(
                children: [
                  Text('1.2k', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text('Followers', style: TextStyle(color: Colors.grey)),
                ],
              ),
              Column(
                children: [
                  Text('500', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text('Following', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 15, // Display 15 placeholder grid items
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
            ),
            itemBuilder: (context, index) {
              return Container(
                color: Colors.grey[300],
                child: const Center(child: Text('Post')),
              );
            },
          ),
        ],
      ),
    );
  }
}