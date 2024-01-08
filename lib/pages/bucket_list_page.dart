import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:bucket_list_app/data/database.dart';
import 'package:bucket_list_app/util/dialog_box.dart';
import 'package:bucket_list_app/util/bucket_list_task_tile.dart';

class BucketListPage extends StatefulWidget {
  const BucketListPage({super.key});

  @override
  State<BucketListPage> createState() => _BucketListPageState();
}

class _BucketListPageState extends State<BucketListPage> {
  // Reference the Hive box
  final _myBox = Hive.box('mybox');
  BucketListDataBase db = BucketListDataBase();

  // Text controller
  final _controller = TextEditingController();
  final _searchController = TextEditingController();
  String _searchQuery = ''; // Variable to store search query

  @override
  void initState() {
    // If there are no to do items
    if (_myBox.get("BUCKETLIST") == null) {
      db.updateDataBase();
    } else {
      // Data exists
      db.loadData();
    }
    super.initState();
  }

  // Checkbox was tapped
  void pressedCheck(int index) {
    setState(() {
      // Move item from bucket list to completed list
      db.completedList.add(db.bucketList[index]);
      db.bucketList.removeAt(index);
    });
    db.updateDataBase();
  }

  // Save new task
  void saveNewTask() {
    String bucketListItem = _controller.text.toString();
    setState(() {
      db.bucketList.add(bucketListItem);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  // Create new task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  // Save edited task
  void saveEditedTask(int index) {
    setState(() {
      String bucketListItem = _controller.text.toString();
      db.bucketList[index] = bucketListItem;
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  // Edit task
  void editTask(int index) {
    _controller.text = db.bucketList[index][0];

    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: () => saveEditedTask(index),
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  // Delete task
  void deleteTask(int index) {
    setState(() {
      db.bucketList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Bucket List",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.green[500],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        backgroundColor: Colors.green[400],
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: TextField(
              controller: _searchController,
              onChanged: (query) {
                // Update the search query as the user types
                setState(() {
                  _searchQuery = query;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search...',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: db.bucketList.isEmpty
                ? const Center(
                    child: Text(
                      "No Bucket List Items",
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                : ListView.builder(
                    itemCount: db.bucketList.length,
                    itemBuilder: (context, index) {
                      // Apply filtering based on the search query
                      if (_searchQuery.isEmpty ||
                          db.bucketList[index]
                              .toLowerCase()
                              .contains(_searchQuery.toLowerCase())) {
                        return BucketListTaskTile(
                          itemName: db.bucketList[index],
                          checkFunction: () => pressedCheck(index),
                          editFunction: (context) => editTask(index),
                          deleteFunction: (context) => deleteTask(index),
                        );
                      } else {
                        return SizedBox
                            .shrink(); // Hidden if not matching the search
                      }
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
