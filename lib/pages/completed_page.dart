import 'package:bucket_list_app/util/completed_tile.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:bucket_list_app/data/database.dart';

class CompletedPage extends StatefulWidget {
  const CompletedPage({super.key});

  @override
  State<CompletedPage> createState() => _CompletedPageState();
}

class _CompletedPageState extends State<CompletedPage> {
  // Reference the Hive box
  final _myBox = Hive.box('mybox');
  BucketListDataBase db = BucketListDataBase();

  @override
  void initState() {
    super.initState();
    db.loadData(); // Load completed list when the CompletedPage is created
  }

  // Delete task
  void deleteTask(int index) {
    setState(() {
      db.completedList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Completed",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.green[500],
      ),
      body: db.completedList.isEmpty
          ? Center(
              child: Text(
                "No Completed Items",
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: db.completedList.length,
              itemBuilder: (context, index) {
                return CompletedTile(
                  taskName: db.completedList[index],
                  deleteFunction: (context) => deleteTask(index),
                );
              },
            ),
    );
  }
}
