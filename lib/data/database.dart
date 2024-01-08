import 'package:hive_flutter/hive_flutter.dart';

class BucketListDataBase {
  // Lists
  List<String> bucketList = [];
  List<String> completedList = [];
  List<String> ideasList = [
    "Climb Mount Everest",
    "Make a million",
    "Ride in a hot air balloon",
    "See the Northern Lights",
  ];

  // Reference Hive box
  final _myBox = Hive.box('myBox');

  // Load data from database
  void loadData() {
    bucketList = _myBox.get("BUCKETLIST") ?? [];
    completedList = _myBox.get("COMPLETEDLIST") ?? [];
    ideasList = _myBox.get("IDEASLIST") ?? [];
  }

  // Update database
  void updateDataBase() {
    _myBox.put("BUCKETLIST", bucketList);
    _myBox.put("COMPLETEDLIST", completedList);
    _myBox.put("IDEASLIST", ideasList);
  }
}
