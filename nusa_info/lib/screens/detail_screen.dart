import 'package:flutter/material.dart';

import '../models/post.dart';
import '../services/post_service.dart';

class DetailScreen extends StatefulWidget {
  final Post post;

  const DetailScreen({super.key, required this.post});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<List<dynamic>> futureComments;
  final PostService postService = PostService();

  @override
  void initState() {
    super.initState();
    futureComments = postService.getComments(widget.post.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail Pengumuman')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.post.title,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(widget.post.body, style: TextStyle(fontSize: 16)),
            Divider(height: 40, thickness: 2),
            Text(
              'Komentar',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: futureComments,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    return ListView.separated(
                      itemCount: snapshot.data!.length,
                      separatorBuilder: (context, index) => Divider(),
                      itemBuilder: (context, index) {
                        final comment = snapshot.data![index];
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            comment['email'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                          subtitle: Text(comment['body']),
                        );
                      },
                    );
                  }
                  return Center(child: Text('Tidak ada komentar'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
