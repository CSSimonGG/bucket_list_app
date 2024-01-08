import 'package:hive_flutter/hive_flutter.dart';

class BucketListDataBase {
  // To Do List
  List bucketList = [];
  List completedList = [];

  // Reference Hive box
  final _myBox = Hive.box('myBox');

  // Load data from database
  void loadData() {
    bucketList = _myBox.get("BUCKETLIST");
    completedList = _myBox.get("COMPLETEDLIST") ?? [];
  }

  // Update database
  void updateDataBase() {
    _myBox.put("BUCKETLIST", bucketList);
    _myBox.put("COMPLETEDLIST", completedList);
  }
}