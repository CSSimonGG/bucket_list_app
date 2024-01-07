import 'package:flutter/material.dart';

class BucketListPage extends StatefulWidget {
  const BucketListPage({super.key});

  @override
  State<BucketListPage> createState() => _BucketListPageState();
}

class _BucketListPageState extends State<BucketListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Bucket List"),
        elevation: 0,
        backgroundColor: Colors.green[500],
      ),
      body: Center(),
    );
  }
}
