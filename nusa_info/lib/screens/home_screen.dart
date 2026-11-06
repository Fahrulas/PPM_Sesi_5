import 'package:flutter/material.dart';

import '../models/post.dart';
import '../services/post_service.dart';
import 'detail_screen.dart';
import 'add_post_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Post>> futurePosts;
  final PostService postService = PostService();

  @override
  void initState() {
    super.initState();
    _loadPosts(); // Panggil API di initState
  }

  void _loadPosts() {
    setState(() {
      futurePosts = postService.getPosts();
    });
  }

  Future<void> _refresh() async {
    _loadPosts();
    await futurePosts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('NusaInfo - Pengumuman')),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder<List<Post>>(
          future: futurePosts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.wifi_off, size: 50, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      'Koneksi Gagal / Internet Mati',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      snapshot.error.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.red),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _loadPosts,
                      child: Text('Coba Lagi'),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final post = snapshot.data![index];
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: ListTile(
                      title: Text(
                        post.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        post.body,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailScreen(post: post),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            }
            return Center(child: Text('Tidak ada data'));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Menunggu hasil dari AddPostScreen
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddPostScreen()),
          );

          if (result == true) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Pengumuman berhasil dibuat!')),
            );
            _loadPosts(); // Refresh list otomatis setelah menambah data
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
