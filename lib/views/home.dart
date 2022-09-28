import 'package:blog_app/widgets/appbar_title.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../services/crud.dart';
import 'add_blog.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CrudMethods crudMethods = CrudMethods();

  QuerySnapshot? blogSnapshot;

  @override
  void initState() {
    crudMethods.getData().then((result) {
      blogSnapshot = result;
      print('BLOGSNAPSHOT: $blogSnapshot');
      setState(() {});
    });
    super.initState();
  }

  Widget blogsList() {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 24),
      itemCount: blogSnapshot?.docs.length,
      itemBuilder: (context, index) {
        print("BLOG TILE: ${blogSnapshot!.docs[index]}");
        return BlogTile(
          author: blogSnapshot?.docs[index].get('author'),
          title: blogSnapshot?.docs[index].get('title'),
          desc: blogSnapshot?.docs[index].get('desc'),
          imgUrl: blogSnapshot?.docs[index].get('imgUrl'),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppbarTitleWidget(),
      ),
      body: Container(
          child: blogSnapshot != null
              ? blogsList()
              : const Center(
                  child: Text("No Record"),
                )),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddBlog()));
            },
          ),
        ],
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String imgUrl, title, desc, author;
  const BlogTile(
      {required this.author,
      required this.desc,
      required this.imgUrl,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24, right: 16, left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            child: Image.network(
              imgUrl,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
              height: 200,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            title.toUpperCase(),
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 2),
          Text(
            desc,
            style: const TextStyle(fontSize: 14),
          ),
          Text(
            'By $author',
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
