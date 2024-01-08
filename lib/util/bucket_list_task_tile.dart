import 'package:flutter/material.dart';

class BucketListTaskTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(BuildContext)? editFunction;
  Function(BuildContext)? deleteFunction;

  BucketListTaskTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.editFunction,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.green[400],
          borderRadius: BorderRadius.circular(12)
        ),
        child: Row(
          children: [
            // checkbox
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.check),
            ),

            // task name
            Text(taskName),

            Spacer(),

            // Edit icon
            IconButton(
              onPressed: () {
                if (editFunction != null) {
                  editFunction!(context);
                }
              },
              icon: Icon(Icons.edit),
            ),

            // Delete icon
            IconButton(
              onPressed: () {
                if (deleteFunction != null) {
                  deleteFunction!(context);
                }
              },
              icon: Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}
