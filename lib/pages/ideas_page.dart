import 'package:bucket_list_app/util/completed_tile.dart';
import 'package:bucket_list_app/util/ideas_tile.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:bucket_list_app/data/database.dart';

class IdeasPage extends StatefulWidget {
  const IdeasPage({super.key});

  @override
  State<IdeasPage> createState() => _IdeasPageState();
}

class _IdeasPageState extends State<IdeasPage> {
  // Reference the Hive box
  final _myBox = Hive.box('mybox');
  BucketListDataBase db = BucketListDataBase();

  @override
  void initState() {
    super.initState();
    db.loadData();
  }

  // Add was tapped
  void addTaskToBucketList(int index) {
    setState(() {
      // Move item from ideas list to bucket list
      db.bucketList.add(db.ideasList[index]);
      db.ideasList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bucket List Ideas",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.green[500],
      ),
      body: db.ideasList.isEmpty
          ? Center(
              child: Text(
                "No Bucket List Ideas",
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: db.ideasList.length,
              itemBuilder: (context, index) {
                return IdeasTile(
                  itemName: db.ideasList[index],
                  addFunction: () => addTaskToBucketList(index),
                );
              },
            ),
    );
  }
}
