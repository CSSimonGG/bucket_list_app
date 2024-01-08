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

  @override
  void initState() {
    db.loadData();
    super.initState();
  }

  // Text controller
  final _controller = TextEditingController();

  // Checkbox was tapped
  pressedCheck(int index) {
    setState(() {
      db.bucketList[index][1] = !db.bucketList[index][1];
    });
    db.updateDataBase();
  }

  // Save new task
  void saveNewTask() {
    setState(() {
      db.bucketList.add([_controller.text, false]);
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
      db.bucketList[index] = [_controller.text, false];
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
        title: Text("My Bucket List"),
        elevation: 0,
        backgroundColor: Colors.green[500],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.bucketList.length,
        itemBuilder: (context, index) {
          return BucketListTaskTile(
            taskName: db.bucketList[index][0],
            taskCompleted: db.bucketList[index][1],
            editFunction: (context) => editTask(index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
